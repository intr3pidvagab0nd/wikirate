# include with option :type_class
def self.included host_class
  host_class.class_eval do
    define_method :badge_hierarchy do
      @badge_hierarchy ||=
        Card::Set::Abstract::BadgeSquad.for_type host_class.hierarchy_type
    end
  end
end

def award_badge_if_earned badge_type
  return unless (badge = earns_badge(badge_type))
  award_badge fetch_badge_card(badge)
end

# @return badge name if count equals its threshold
def earns_badge action
  badge_hierarchy.earns_badge action
end

def award_badge badge_card
  name_parts = [Auth.current, badge_card.badge_type, :badges_earned]
  badge_pointer =
    subcard(name_parts) ||
      attach_subcard(Card.fetch(name_parts, new: { type_id: PointerID }))
  badge_pointer.add_badge_card badge_card
end

def fetch_badge_card badge_name
  badge_card = Card.fetch badge_name
  raise ArgumentError, "not a badge: #{badge_name}" unless badge_card
  badge_card
end

def action_count action, user=nil
  send "#{action}_count", user
end

format :html do
  view :overview do

  end
end
