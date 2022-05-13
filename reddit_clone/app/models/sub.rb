class Sub < ApplicationRecord

    belongs_to :moderator,
        foreign_key: :moderator_id,
        class_name: :User
end
