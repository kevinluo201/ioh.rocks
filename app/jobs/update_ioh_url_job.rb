class UpdateIohUrlJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    @base_url = 'https://ioh.tw'
    @doc = Nokogiri::HTML(open(@base_url + '/talks'))

    # get all talks information
    loop do
      @doc.xpath('//article').each do |article|
        ioh = IohUrl.find_or_initialize_by(
                # \u4e00-\u9fa5 is Chinese codeset
                name: article.xpath('.//a')[1].content.match(/[\u4e00-\u9fa5]+$/).to_s,
                school: article.xpath('.//a')[3].content
              )
        ioh.ioh_url = @base_url + article.xpath('.//a')[1]['href']

        ioh.save if ioh.new_record? || ioh.changed?
      end

      # loop until the last page
      break unless next_page?
    end

    Live.all.each do |live|
      ioh_url = IohUrl.where(name: live.name).first
      if ioh_url
        live.ioh_url = ioh_url.ioh_url
        live.save if live.changed?
      end
    end
  end

  def next_page?
    next_page = @doc.css('.next').first
    if next_page
      @doc = Nokogiri::HTML(open(@base_url + next_page['href']))
    else
      nil
    end
  end
end
