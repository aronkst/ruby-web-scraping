class Exclude
  attr_reader :values

  def initialize(find, values)
    @find = find
    @values = values

    exclude_values
  end

  private

  def exclude_values
    @find.keys.each do |key|
      if is_array?(key)
        exclude_many(key)
      else
        exclude_one(key)
      end
    end
  end

  def is_array?(key)
    !@find[key]["find"].nil?
  end

  def exclude_loop(value, exclude)
    exclude.each do |e|
      return true if exclude_value(value, e)
    end

    false
  rescue
    false
  end

  def exclude_value(value, exclude)
    case exclude[0]
    when "=="
      value == exclude[1]
    when "!="
      value != exclude[1]
    when ">"
      value > exclude[1]
    when ">="
      value >= exclude[1]
    when "<"
      value < exclude[1]
    when "<="
      value <= exclude[1]
    when "like"
      value.include?(exclude[1])
    when "not"
      !exclude_value(value, exclude[1..-1])
    else
      false
    end
  end

  def exclude_one(key)
    return if @find[key]["exclude"].nil?
    @values.delete(key) if exclude_loop(@values[key], @find[key]["exclude"])
  end

  def exclude_many(key)
    @find[key]["find"].each do |find_child_key, find_child_value|
      @values[key].each_with_index do |values_child, index|
        next if find_child_value["exclude"].nil?
        @values[key][index].delete(find_child_key) if exclude_loop(values_child[find_child_key], find_child_value["exclude"])
      end
    end
  end
end