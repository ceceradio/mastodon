# frozen_string_literal: true

class SuspendAccountService < BaseService
  def call(account)
    @account = account

    unpush_from_home_timelines!
    unpush_from_list_timelines!
  end

  private

  def unpush_from_home_timelines!
    @account.followers_for_local_distribution.find_each do |follower|
      FeedManager.instance.unmerge_from_timeline(@account, follower)
    end
  end

  def unpush_from_list_timelines!
    @account.lists_for_local_distribution.find_each do |list|
      FeedManager.instance.unmerge_from_list(@account, list)
    end
  end
end
