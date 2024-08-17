# frozen_string_literal: true

module TagsHelper
  def icon_tag(name)
    "<em class='icon ni ni-#{name}' aria-label='#{name}'></em>".html_safe
  end

  def header_link_tag(link, label, icon)
    "<li class='nk-block-tools-opt'>
      <a href='#{link}' class='btn btn-white btn-dim btn-outline-light'>
        #{icon_tag(icon)}
        <span>#{label}</span>
      </a>
    </li>".html_safe
  end

  def order_status_tag(status)
    status_mapping = {
      0 => "<span class='badge badge-dim bg-success'>En cours</span>",
      1 => "<span class='badge badge-dim bg-danger'>Annulée</span>",
      2 => "<span class='badge badge-dim bg-primary'>Livrée</span>"
    }

    status_mapping.fetch(status.to_i, "<span class='badge badge-dim bg-secondary'>État inconnu</span>").html_safe
  end

  def boolean_tag(status)
    tag = status ? 'success' : 'danger'
    text = status ? 'OUI' : 'NON'
    "<span class='text text-#{tag}'>#{text}</span>".html_safe
  end
end
