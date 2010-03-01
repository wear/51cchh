require 'nokogiri'
require 'open-uri'

desc "Fetch dianping vendors"     
task :fetch_vendors => :environment do
  bj_area = {:chongwen => '崇文区', :xicheng => '西城区', :haiding => '海淀区',:dongcheng => '东城区', :xuanwu => '宣武区', :zhaoyang => '朝阳区'}
  bj_caixi = {:beijing => '北京菜',:rucai => '鲁菜',:xiangcai => '湘菜 ',:chuancai => '川菜', :yuecai => '粤菜', :guizhou => '贵州菜', :dongbei => '东北菜',
   :dongnanya => '东南亚', :hanguo => '韩国菜', :huoguo => '火锅', :qingzhen => '新疆/清真', :riben => '日本',:sucai  => '素菜',:jiangzhe => '江浙菜',
   :xiaochi => '小吃', :xican => '西餐',:haixian => '海鲜', :zizhu => '自助餐', :mianbao => '面包甜点', :qita => '其他'}
  bj_area.each do |area,area_name|
   bj_caixi.each do |key,value|   
   [50,100,200,300].each do |avg|  
    (1..5).step do |n|   
    if File.exist?(Rails.root + "public/static/#{area}/#{avg}/#{key}#{n}.html") 
      doc = Nokogiri::HTML(open(Rails.root + "public/static/#{area}/#{avg}/#{key}#{n}.html"))
      doc.css('div.searchResult dd').each do |v|
         vendor = Vendor.create(:name => v.css("ul.detail li")[0].text.gsub(/推广,*/,''), 
                      :address => v.css("ul.detail li")[1].text.gsub(/\d{8}|地址:/,''),
                      :phone => v.css("ul.detail li")[1].text.scan(/\d{8}/)[0],
                      :tags => v.css("ul.detail li")[2].text.gsub(/标签:/,''),
                      :category => value,:env => v.at_css('span.score2').text,:avg => v.at_css('span.score4').text.gsub("￥",''),
                      :taste => v.at_css('span.score1').text, :service => v.at_css('span.score3').text,
                      :sum => (v.at_css('span.score2').text.to_i + v.at_css('span.score1').text.to_i + v.at_css('span.score3').text.to_i)/3 ,
                      :city => 'bj',
                      :area => area_name )
       end
     end
   end   
 end
   end 
  end
end