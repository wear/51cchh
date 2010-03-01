# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format 
# (all these examples are active by default):
# ActiveSupport::Inflector.inflections do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
# end                                


  VOTESPEC = {
    'COMMON' => 1,        # 普通投票项
    'AVG' => 2,  # 平均消费
    'SUM' => 3     # 总分
  }

COMMONOPT = [
    ["请选择",''],
    ["非常好",5],
    ["很好",4],
    ["好",3],
    ["一般",2],
    ["差",1]
  ] 
  
TIMERANGE = [
    ["早市",0],
    ["中午",1],
    ["晚市",2]
  ]

