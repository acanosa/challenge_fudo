require 'redcarpet'

class OpenApiController

  CACHE_DURATION = 24 * 60 * 60

  def initialize(file_path)
    @file_path = file_path
    @content = nil 
    @last_modified = nil
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
  end

  def call(env)
    if @content.nil? || file_changed?
      file_contents = File.read(@file_path)
      @content = redcarpet::Markdown.new()
      @last_modified = File.mtime(@file_path).httpdate
    end


    headers = {
      "content-type" => "text/markdown",
      "cache-control" => "public, max-age=#{CACHE_DURATION}",
      "last-modified" => @last_modified
    }

    [200, headers, [@content]]
  end
  
  private

  def file_changed?
    File.mtime(@file_path).httpdate != @last_modified
  end
end

