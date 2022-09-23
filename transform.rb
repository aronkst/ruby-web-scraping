class Transform
  attr_reader :values

  def initialize(find, values)
    @find = find
    @values = values

    transform_values
  end

  private

  def transform_values
    @find.each_key do |key|
      if array?(key)
        transform_many(key)
      else
        transform_one(key)
      end
    end
  end

  def array?(key)
    !@find[key]['find'].nil?
  end

  def transform_loop(value, transform)
    transform.each do |t|
      value = transform_value(value, t)
    end

    value
  rescue
    nil
  end

  def transform_value(value, transform)
    case transform[0]
    when 'split'
      value.split(transform[1])[transform[2]]
    when 'replace'
      value.gsub(transform[1], transform[2])
    when 'prepend'
      transform[1] + value
    when 'append'
      value + transform[1]
    end
  end

  def transform_one(key)
    return if @find[key]['transform'].nil? || @values[key].nil?

    @values[key] = transform_loop(@values[key], @find[key]['transform'])
  end

  def transform_many(key)
    @find[key]['find'].each do |find_child_key, find_child_value|
      @values[key].each_with_index do |values_child, index|
        next if find_child_value['transform'].nil? || values_child[find_child_key].nil?

        @values[key][index][find_child_key] =
          transform_loop(values_child[find_child_key], find_child_value['transform'])
      end
    end
  end
end
