describe Scheduler::ReconciledSchedule do
  before do
    @coach = create(:coach)
  end

  it "should be a hash" do
    reconciled_schedule = Scheduler::ReconciledSchedule.new(coach: @coach).to_hash

    expect(reconciled_schedule.class).to eq(Hash)
  end

  context "when availability" do
    it "should have exact dates" do
      create(:availability,
             coach: @coach,
             start_at: beginning_of_month,
             end_at: end_of_month,
             priority: 1)
      reconciled_schedule = Scheduler::ReconciledSchedule.new(coach: @coach).to_hash

      expect(reconciled_schedule.count).to eq(days_to_month_end)
    end
  end

  context "when availability have included calendar days" do
    it "should have exact dates" do
      create(:availability,
             coach: @coach,
             start_at: beginning_of_next_month,
             end_at: end_of_next_month,
             permitted_weekdays: weekdays,
             priority: 1)
      reconciled_schedule = Scheduler::ReconciledSchedule.new(coach: @coach).to_hash

      expect(reconciled_schedule.count).to eq(number_of_weekdays)
    end
  end

  context "when availabilities" do
    it "should have exact dates" do
      create(:availability,
             coach: @coach,
             start_at: beginning_of_month,
             end_at: end_of_month,
             priority: 1)
      create(:availability,
             coach: @coach,
             start_at: beginning_of_next_month,
             end_at: end_of_next_month,
             permitted_weekdays: weekdays,
             priority: 1)
      reconciled_schedule = Scheduler::ReconciledSchedule.new(coach: @coach).to_hash

      expect(reconciled_schedule.count).to eq(days_to_month_end + number_of_weekdays)
    end
  end

  context "when availabilities have overlap" do
    it "should have exact dates" do
      create(:availability,
             coach: @coach,
             start_at: beginning_of_month,
             end_at: beginning_of_next_month,
             priority: 1)
      create(:availability,
             coach: @coach,
             start_at: end_of_month,
             end_at: end_of_next_month,
             permitted_weekdays: weekdays,
             priority: 2)
      reconciled_schedule = Scheduler::ReconciledSchedule.new(coach: @coach).to_hash

      expect(reconciled_schedule.count).to eq(days_to_month_end + number_of_weekdays)
    end
  end
end

def number_of_weekdays
  (beginning_of_next_month..end_of_next_month).inject(0) do |count, day|
    count += 1 if weekdays.include?(day.strftime("%A").downcase)
    count
  end
end

def weekdays
  [beginning_of_next_month.strftime("%A").downcase]
end

def beginning_of_month
  DateTime.now.beginning_of_month.to_date
end

def end_of_month
  DateTime.now.end_of_month.to_date
end

def beginning_of_next_month
  DateTime.now.next_month.beginning_of_month.to_date
end

def end_of_next_month
  DateTime.now.next_month.end_of_month.to_date
end

def days_to_month_end
  DateTime.now.end_of_month.day - DateTime.yesterday.day
end
