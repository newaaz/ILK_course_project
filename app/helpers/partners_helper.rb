module PartnersHelper
  def partner_avatar_or_placeholder
    if current_partner.avatar.present?
      image_tag current_partner.avatar.url, class: 'avatar-img rounded-circle shadow'
    else
      image_tag("theme/user.png", class: 'avatar-img rounded-circle shadow') 
    end      
  end

  def to_day_and_month(date)
    if date.present?
      date.strftime('%d.%m')
    else
      "Дата не указана"
    end
  end
end
