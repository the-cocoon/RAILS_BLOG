module PubTagsCloudHelper
  def pub_tags_cloud rels, klasses, &block
    res_items = []

    group_count = klasses.compact.count
    return res_items if group_count.zero?
    group_count = (rels.to_a.count.to_f / group_count.to_f).round

    rels.in_groups_of(group_count, false).each_with_index do |group, index|
      res_items << group.map do |rel_item|
        klass = klasses[index]
        puts index
        puts klass
        block.call(rel_item, klass)
      end
    end

    res_items.flatten
  end # pub_tags_cloud
end