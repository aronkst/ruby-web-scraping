class Exclude
  attr_reader :values

  def initialize(find, values)
    @find = find
    @values = values

    exclude_values
  end

  private

  def exclude_values
    @find.each_key do |key|
      if array?(key)
        exclude_many(key)
      else
        exclude_one(key)
      end
    end
  end

  def array?(key)
    !@find[key]['find'].nil?
  end

  def exclude_loop(value, exclude)
    return false if exclude['exclude'].nil?

    exclude['exclude'].each do |e|
      return true if exclude_value(value, e)
    end

    false
  rescue
    false
  end

  def exclude_value(value, exclude)
    case exclude[0]
    when 'null'
      value.nil?
    when '=='
      value == exclude[1]
    when '!='
      value != exclude[1]
    when '>'
      value > exclude[1]
    when '>='
      value >= exclude[1]
    when '<'
      value < exclude[1]
    when '<='
      value <= exclude[1]
    when 'like'
      value.downcase.include?(exclude[1].downcase)
    when 'not'
      !exclude_value(value, exclude[1..])
    else
      false
    end
  end

  def exclude_one(key)
    @values.delete(key) if exclude_loop(@values[key], @find[key])
  end

  def exclude_many(key)
    @find[key]['find'].each do |find_child_key, find_child_value|
      list_exclude = []
      @values[key].each_with_index do |values_child, index|
        if exclude_loop(values_child[find_child_key], find_child_value)
          list_exclude.append(index)
          next
        end
      end
      list_exclude.reverse.each do |index|
        @values[key].delete_at(index)
      end
    end
  end
end
