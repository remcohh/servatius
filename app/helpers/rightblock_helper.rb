module RightblockHelper
  def rightblock_helper
    out = ''
    Comfy::Cms::Page.includes(:fragments).where('comfy_cms_fragments.identifier' => 'news_title').each do |page|
      out << cms_fragment_content(:news_title, page)
    end
    out
  end
end
