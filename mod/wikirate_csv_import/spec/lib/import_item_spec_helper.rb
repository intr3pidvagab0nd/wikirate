# helper module for specs for classes that inherit from ImportItem
module ImportItemSpecHelper
  def item_name_from_args args, keys
    Card::Name[keys.map { |k| args[k] }]
  end

  def item_name args={}
    item_name_from_args item_hash(args), item_name_parts
  end

  def item_hash args={}
    default_item_hash.merge args
  end

  def item_object hash={}
    described_class.new item_hash(hash)
  end

  def validate item_hash={}
    item = item_object item_hash
    item.validate!
    item
  end

  def import item_hash={}
    item = item_object item_hash
    item.import
    item
  end
end
