module Hyper
  module Core
    module Service
      class Interaction < Base
        self.resource_scope = 'venue'

        PROPERTIES = [
          :alr,
          :alr_user_feedback,
          :bookmarked,
          :comments_count,
          :content,
          :created_at,
          :data,
          :engagements,
          :engagements_count,
          :followed_by_count,
          :id,
          :identity_comments,
          :identity_likes,
          :interaction_type,
          :likes_count,
          :network,
          :network_id,
          :nuid,
          :replies_count,
          :reposted,
          :retweet_count,
          :ugc_permission_state,
          :updated_at,
          :venue_id,
        ]

        attr_accessor *PROPERTIES
      end
    end
  end
end
