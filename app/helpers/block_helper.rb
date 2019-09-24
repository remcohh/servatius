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
    Comfy::Blog::Post.all.order('published_at desc').each do |post|
      out << "<div class='row mb-5'>"
      out << "<div class='col-md-12'>"
      first_image = Nokogiri::HTML(post.content_cache).search("img")[0].attribute_nodes[0].value
      first_paragraph = Nokogiri::HTML(post.content_cache).search("p")[0].children[0].text
      out << "<h4>#{post.published_at.strftime('%d-%m-%Y')}: #{post.title}</h4>"
      out << "<img src='#{first_image}' class='float-md-left mr-3 mt-1'>"
      out << "<p>#{first_paragraph}</p>"
      out << link_to('Lees verder', comfy_blog_post_path(@cms_site.path, post.year, post.month, post.slug))
      out << "</div>"
      out << "</div>"
    end
    out.html_safe
  end

  def published_gigs_helper(nr=4, ensemble_id = nil)
    out = '<h4>Agenda</h4>'
    out << '<ul class="list-group">'
    Gig.published(ensemble_id).order('date_time asc').first(nr).each do |gig|
      out << '<li class="list-group-item">'
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
