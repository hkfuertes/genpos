class Assestment < ApplicationRecord
  belongs_to :classroom
  belongs_to :student

  # classroom_id, student_id, { id => val }
  def self.calculate_insights(classroom)
    values = digest_assestments extract_assestments(classroom.assestment)
    return [[], [], []] if values.empty?

    # TODO: Check the mean count, wich one to use?
    # Ideally both counts should be equal, for now, assestment count for pretier resutls
    avgs = calculate_avgs(values, classroom.assestment.count)

    popular = select_popular(values, avgs)
    rejected = select_rejected(values, avgs)
    ignored = select_ignored(values, avgs)

    [popular, rejected, ignored]
  end

  private_class_method def self.select_popular(values, avgs)
    _, negative_avg, impact = avgs

    # Popular (>= impact) && (<= negative_avg)
    values.select do |_, value|
      value[:positives] >= impact &&
        value[:negatives] <= negative_avg
    end.keys
  end

  private_class_method def self.select_rejected(values, avgs)
    positive_avg, _, impact = avgs

    # Rejected (<= positive_avg) && (>= impact)
    values.select do |_, value|
      value[:positives] <= positive_avg &&
        value[:negatives] >= impact
    end.keys
  end

  private_class_method def self.select_ignored(values, avgs)
    _, _, impact = avgs

    # Ignored (sum <= impact)
    values.select do |_, value|
      value[:positives] + value[:negatives] <= impact
    end.keys
  end

  private_class_method def self.extract_assestments(assestments)
    assestments.map { |a| JSON.parse a[:assestments] }
  end

  private_class_method def self.digest_assestments(assestments)
    return {} if assestments.nil?

    # [{ id: 1, id2: -1 }, {id: -1, id2: 1}]
    # { id: {positives: 5, negatives: 4}}
    values = {}
    assestments.each do |el|
      el.each do |id, value|
        values[id] = { positives: 0, negatives: 0 } unless values.key? id
        values[id][:positives] += 1 if value.to_i == 1
        values[id][:negatives] += 1 if value.to_i == -1
      end
    end
    values
  end

  private_class_method def self.calculate_avgs(digested, count)
    return [0, 0, 0] if digested.empty?

    # Change count with classroom#
    positive_avg = digested.map { |_, v| v[:positives] }.sum.fdiv(count)
    negative_avg = digested.map { |_, v| v[:negatives] }.sum.fdiv(count)
    impact = positive_avg + negative_avg

    [positive_avg, negative_avg, impact]
  end
end
