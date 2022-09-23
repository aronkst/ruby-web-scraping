class Convert
  attr_reader :values

  def initialize(find, values)
    @find = find
    @values = values

    convert_values
  end

  private

  def convert_values
    @find.each_key do |key|
      if array?(key)
        convert_many(key)
      else
        convert_one(key)
      end
    end
  end

  def array?(key)
    !@find[key]['find'].nil?
  end

  def convert_value(value, convert)
    case convert
    when 'string'
      String(value)
    when 'integer'
      Integer(value)
    when 'float'
      Float(value)
    when 'boolean'
      String(value).downcase == 'true'
    end
  rescue
    nil
  end

  def convert_one(key)
    return if @find[key]['convert'].nil? || @values[key].nil?

    @values[key] = convert_value(@values[key], @find[key]['convert'])
  end

  def convert_many(key)
    @find[key]['find'].each do |find_child_key, find_child_value|
      @values[key].each_with_index do |values_child, index|
        next if find_child_value['convert'].nil? || values_child[find_child_key].nil?

        @values[key][index][find_child_key] = convert_value(values_child[find_child_key], find_child_value['convert'])
      end
    end
  end
end
