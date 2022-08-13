class Assestment < ApplicationRecord
  belongs_to :classroom
  belongs_to :student

  # classroom_id, student_id, { id => val }
  def self.calculate_insights(assestments)
    return [[],[]]
    values = digest_assestments assestments.to_h { |a| a[:assestments] }.flatten
    positive_mean, negative_mean, impact = calculate_means values

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

  def self.digest_assestments(assestments)
    return {} if assestments.nil?

    # { id: {positives: 5, negatives: 4}}
    values = {}
    assestments.each do |id, value|
      values[id][:positives] += 1 if value == 1
      values[id][:negatives] += 1 if value == -1
    end
    values
  end

  def self.calculate_means(digested)
    return [0, 0, 0] if digested.empty?

    positive_mean = digested.reduce(0) { |memo, value| memo + value[:positives] } / assestments.count
    negative_mean = digested.reduce(0) { |memo, value| memo + value[:negatives] } / assestments.count
    impact = positive_mean + negative_mean

    [positive_mean, negative_mean, impact]
  end
end
