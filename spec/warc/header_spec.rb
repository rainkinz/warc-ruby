require 'spec_helper.rb'
describe Warc::Header do
  before(:each) do
    @header=Warc::Header.new({
            "WARC-Type"=> "response",
            "WARC-Record-ID" => "<record-1>",
            "WARC-Date" => "2000-01-02T03:04:05Z",
            "Content-Length" => "10"
            })
  end
  
  it "should have attributes for mandatory fields" do
    @header.type.should eq "response"
    @header.record_id.should eq "<record-1>"
    @header.date.should eq "2000-01-02T03:04:05Z"
    @header.content_length.should eq 10
  end
  
  it "should be case-insensitive to field names" do
    ["WARC-Type", "warc-type", "WARC-TYPE"].each do |key|
      @header[key].should eq "response"
    end
  end

  it "should assume a content-lenght of 0 if unspecified" do
    rec = Warc::Record.new({"WARC-Type" => "Resouce"})
    rec.header.content_length.should eq 0
  end
end