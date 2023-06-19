module PropertiesHelper
  def link_to_messenger(messenger, phone_number)
    url = Contact::MESSENGERS_URLS[messenger.to_sym][:url_start] + phone_number.gsub(/[^0-9]/, '') + Contact::MESSENGERS_URLS[messenger.to_sym][:url_end]
    color_class = "btn btn-#{Contact::MESSENGERS_URLS[messenger.to_sym][:color]}-soft btn-sm"
    icon_class = "'bi bi-#{Contact::MESSENGERS_URLS[messenger.to_sym][:icon]} me-1'"
    
    link_to url, class: color_class, target: '_blank' do
      "<i class=#{icon_class}'></i>".html_safe + messenger.capitalize  
    end  
  end
end

