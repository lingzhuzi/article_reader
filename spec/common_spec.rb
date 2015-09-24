require 'rails_helper'

RSpec.describe Common, :type => :model do

  it '补全url' do
    base_url = 'http://baidu.com/test/1'
    href_1 = '/1.html'
    href_2 = '1.html'
    href_3 = './1.html'
    href_4 = '../1.html'
    href_5 = '?1.html'
    href_6 = '//1.html'
    href_7 = 'http://baidu.com/1.html'

    expect(Common.complete_url(base_url, href_1)).to eq('http://baidu.com/1.html')
    expect(Common.complete_url(base_url, href_2)).to eq('http://baidu.com/test/1.html')
    expect(Common.complete_url(base_url, href_3)).to eq('http://baidu.com/test/1.html')
    expect(Common.complete_url(base_url, href_4)).to eq('http://baidu.com/1.html')
    expect(Common.complete_url(base_url, href_5)).to eq('http://baidu.com/test/1?1.html')
    expect(Common.complete_url(base_url, href_6)).to eq('http://1.html')
    expect(Common.complete_url(base_url, href_7)).to eq('http://baidu.com/1.html')
  end

  it '合法的href' do
    href_1 = '/1.html'
    href_2 = '1.html'
    href_3 = '.1.html'
    href_4 = '?1.html'

    expect(Common.valid_url? href_1).to eq(true)
    expect(Common.valid_url? href_2).to eq(true)
    expect(Common.valid_url? href_3).to eq(true)
    expect(Common.valid_url? href_4).to eq(true)
  end

  it '不合法的href' do
    href_1 = 'javascript:void());'
    href_2 = 'mailto:1.html'
    href_3 = 'irc:1.html'

    expect(Common.valid_url? href_1).to eq(false)
    expect(Common.valid_url? href_2).to eq(false)
    expect(Common.valid_url? href_3).to eq(false)
  end

end