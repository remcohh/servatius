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
    Comfy::Blog::Post.all.each do |post|
      first_image = Nokogiri::HTML(post.content_cache).search("img")[0].attribute_nodes[0].value
      first_paragraph = Nokogiri::HTML(post.content_cache).search("p")[0].children[0].text
      out << "<div class='ppst_date'>#{post.published_at.strftime('%d-%m-%Y')}</div>"
      out << "<h3>#{post.title}</h3>"
      out << "<img src='#{first_image}' class='float-md-left mr-3'>"
      out << "<p>#{first_paragraph}</p>"
      out << link_to('Lees verder', comfy_blog_post_path(@cms_site.path, post.year, post.month, post.slug))
    end
    out.html_safe
  end

  def published_gigs_helper(nr=5, ensemble_id = nil)
    out = '<h4>Agenda</h4>'
    out << '<ul>'
    Gig.published(ensemble_id).last(nr).each do |gig|
      out << '<li>'
      out << "<div>#{gig.date_time.strftime('%d-%m-%Y')} om #{gig.date_time.strftime('%H:%M')}:</div>"
      out << link_to(gig.title, published_gig_path(gig))
      out << '</li>'
    end
    out << '</ul>'
    out << link_to('Volledige agenda', published_gigs_path)
    out.html_safe
  end

  def get_fragment(page_id, identifier)
    Comfy::Cms::Fragment.where(record_id: page_id).where(identifier: identifier).first
  end
end
