require 'spec_helper'

describe Setting do
  let!(:posts) { FactoryGirl.create_list(:post, 15) }

  context "site configuration" do
    it "starts with default config" do
      expect(Setting.get('site_text')['settings']['headings']['site_title']).to eq("Kodiak")
    end

    it "updates title" do
      s = Setting.get('site_text')
      s['settings']['headings']['banner_title'] = "fart"
      Setting.set(s)
      expect(Setting.get('site_text')['settings']['headings']['banner_title']).to eq("fart")
    end
  end
end


