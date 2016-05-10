require 'rails_helper'

describe TextVerseWorker do
  it "enqueues a text verse worker" do
    subscription = create(:subscription)
    verse = create(:verse)
    subject.perform(subscription.id, verse.id)
    expect(TextVerseWorker).to have_enqueued_jobs(1)
  end
end
