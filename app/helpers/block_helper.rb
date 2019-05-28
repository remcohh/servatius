module BlockHelper

  def rightblock_helper
    out = ''
    # Comfy::Cms::Page.includes(:fragments).where('comfy_cms_fragments.identifier' => 'news_title').each do |page|
    #   out << cms_fragment_content(:news_title, page)
    # end
    # out

    s = ActiveStorage::Attachment.last.variant(resize: "100x100")

    image_tag(url_for(s))
  end


  def newsblock_helper
    out = ''
    Comfy::Cms::Fragment.where(identifier: 'news_title').each do |r|
      out << '<div class="row">'
      out << '<div class="col-md-4">'
      image_part =  get_fragment(r.record_id, 'newsimage')
      out << image_tag(ActiveStorage::Attachment.where(record_id: image_part.id).first.variant(resize: "400x400"))
      out << '</div>'
      out << '<div class="col-md-6">'
      out << '<h3>'
      out << get_fragment(r.record_id, 'news_date').datetime.strftime('%d-%m-%Y') + ': '
      out << r.content
      out << '</h3>'
      out << '<p>'
      out << get_fragment(r.record_id, 'content').content
      out << '</p>'
      out << '</div>'
      out << '</div>'
      out
    end

    out.html_safe
  end


  def get_fragment(page_id, identifier)
    Comfy::Cms::Fragment.where(record_id: page_id).where(identifier: identifier).first
  end



end
