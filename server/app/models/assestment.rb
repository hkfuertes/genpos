class Assestment < ApplicationRecord
  belongs_to :classroom
  belongs_to :student

  # classroom_id, student_id, { id => val }
  def self.calculate_insights(classroom)
    values = digest_assestments extract_assestments(classroom.assestment)
    return [[], []] if values.empty?

    # TODO: Check the mean count, wich one to use?
    positive_mean, negative_mean, impact = calculate_means(values, classroom.assestment.count)

    # Popular (>= impact) && (<= negative_mean)
    popular = values.select do |_, value|
      value[:positives] >= impact &&
        value[:negatives] <= negative_mean
    end.keys

    # Rejected (<= positive_mean) && (>= impact)
    rejected = values.select do |_, value|
      value[:positives] <= positive_mean &&
        value[:negatives] >= impact
    end.keys

    [popular, rejected]
  end

  def self.extract_assestments(assestments)
    assestments.map { |a| JSON.parse a[:assestments] }
  end

  def self.digest_assestments(assestments)
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

  def self.calculate_means(digested, count)
    return [0, 0, 0] if digested.empty?

    # Change count with classroom#
    positive_mean = digested.map { |_, v| v[:positives] }.sum.fdiv(count)
    negative_mean = digested.map { |_, v| v[:negatives] }.sum.fdiv(count)
    impact = positive_mean + negative_mean

    [positive_mean, negative_mean, impact]
  end
end
