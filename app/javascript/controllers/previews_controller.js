import { Controller } from "@hotwired/stimulus"

// Fileuploader
import "../custom/plugins/fileuploader.min.js"

// Masked Input
import IMask from 'imask';

// Connects to data-controller="previews"
export default class extends Controller {
  static targets = ["input", "preview"]
  
  connect() {
    //Phone mask field (need move to some else controller)
    const phoneMaskField = document.querySelector('.phone-mask');
    if (phoneMaskField) {
      const phoneMask = IMask(
        document.querySelector(phoneMaskField), {
          mask: '+{7}(000)000-00-00'
        });
    }  

    // enable fileuploader plugin for images
    $('.images-upload-field').fileuploader({
      captions: 'ru',
      changeInput: ' ',
      theme: 'thumbnails',
      enableApi: true,
      addMore: true,
      limit: 35,
      fileMaxSize: 5,
      extensions: ['jpg', 'jpeg', 'png'],
      thumbnails: {
        box: '<div class="fileuploader-items">' +
                        '<ul class="fileuploader-items-list">' +
                  '<li class="fileuploader-thumbnails-input"><div class="fileuploader-thumbnails-input-inner"><i>+</i></div></li>' +
                        '</ul>' +
                    '</div>',
        item: '<li class="fileuploader-item">' +
                '<div class="fileuploader-item-inner">' +
                            '<div class="type-holder">${extension}</div>' +
                            '<div class="actions-holder">' +
                      '<button type="button" class="fileuploader-action fileuploader-action-remove" title="${captions.remove}"><i class="fileuploader-icon-remove"></i></button>' +
                            '</div>' +
                            '<div class="thumbnail-holder">' +
                                '${image}' +
                                '<span class="fileuploader-action-popup"></span>' +
                            '</div>' +
                            '<div class="content-holder"><h5>${name}</h5><span>${size2}</span></div>' +
                              '<div class="progress-holder">${progressBar}</div>' +
                        '</div>' +
                    '</li>',
        item2: '<li class="fileuploader-item">' +
                '<div class="fileuploader-item-inner">' +
                            '<div class="type-holder">${extension}</div>' +
                            '<div class="actions-holder">' +
                      '<a href="${file}" class="fileuploader-action fileuploader-action-download" title="${captions.download}" download><i class="fileuploader-icon-download"></i></a>' +
                      '<button type="button" class="fileuploader-action fileuploader-action-remove" title="${captions.remove}"><i class="fileuploader-icon-remove"></i></button>' +
                            '</div>' +
                            '<div class="thumbnail-holder">' +
                                '${image}' +
                                '<span class="fileuploader-action-popup"></span>' +
                            '</div>' +
                            '<div class="content-holder"><h5 title="${name}">${name}</h5><span>${size2}</span></div>' +
                              '<div class="progress-holder">${progressBar}</div>' +
                        '</div>' +
                    '</li>',
        startImageRenderer: true,
              canvasImage: false,
        _selectors: {
          list: '.fileuploader-items-list',
          item: '.fileuploader-item',
          start: '.fileuploader-action-start',
          retry: '.fileuploader-action-retry',
          remove: '.fileuploader-action-remove'
        },
        onItemShow: function(item, listEl, parentEl, newInputEl, inputEl) {
          var plusInput = listEl.find('.fileuploader-thumbnails-input'),
                      api = $.fileuploader.getInstance(inputEl.get(0));
          
                  plusInput.insertAfter(item.html)[api.getOptions().limit && api.getChoosedFiles().length >= api.getOptions().limit ? 'hide' : 'show']();
          
          if(item.format == 'image') {
            item.html.find('.fileuploader-item-icon').hide();
          }
        },
        onItemRemove: function(html, listEl, parentEl, newInputEl, inputEl) {
            var plusInput = listEl.find('.fileuploader-thumbnails-input'),
        api = $.fileuploader.getInstance(inputEl.get(0));
        
            html.children().animate({'opacity': 0}, 200, function() {
                html.remove();
                
                if (api.getOptions().limit && api.getChoosedFiles().length - 1 < api.getOptions().limit)
                    plusInput.show();
            });
        }
      },
      dragDrop: {
        container: '.fileuploader-thumbnails-input'
      },
      afterRender: function(listEl, parentEl, newInputEl, inputEl) {
        var plusInput = listEl.find('.fileuploader-thumbnails-input'),
          api = $.fileuploader.getInstance(inputEl.get(0));

        plusInput.on('click', function() {
          api.open();
        });
            
        api.getOptions().dragDrop.container = plusInput;
      }
    });
  }

  preview() {
    let input = this.inputTarget;
    let preview = this.previewTarget;
    let file = input.files[0];
    let reader = new FileReader();

    // проверяем тип файла
    if (![ 'image/jpeg', 'image/png', 'image/gif' ].includes(file.type)) {
      alert('Можно загрузить только изображения')
      input.value = ''
      return
    }
    // проверяем размер файла
    if (file.size > 5 * 1024 * 1024) {
      alert('Файл должен быть мене 5 МБ.')
      input.value = ''
      return
    }

    reader.onloadend = function() {
      preview.src = reader.result;      
    }

    if (file) {
      reader.readAsDataURL(file);
    } else {
      preview.src = "https://via.placeholder.com/300x200";
    }

  }


}
