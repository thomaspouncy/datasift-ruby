require './auth'
class HistoricsPreviewApi < DataSiftExample
  def initialize
    super
    run
  end

  def run
    begin
      puts 'Creating hash'
      stream = @datasift.compile 'interaction.content contains "datasift"'
      hash   = stream[:data][:hash]

      puts 'Creating a preview'
      # see http://dev.datasift.com/docs/rest-api/previewcreate for docs
      parameters = 'interaction.author.link,targetVol,hour;interaction.type,freqDist,10'
      start      = Time.now.to_i - (3600 * 48) # 48hrs ago
      source     = @datasift.historics_preview.create(hash, parameters, start)
      puts source

      puts 'Getting preview data'
      puts @datasift.historics_preview.get source[:data][:id]

    rescue DataSiftError => dse
      puts dse.message
    end
  end
end

HistoricsPreviewApi.new