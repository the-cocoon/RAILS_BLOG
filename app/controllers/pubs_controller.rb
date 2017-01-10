class PubsController < RailsBlogController
  def index
    @hub       = Hub.published.friendly_first(:main)
    @root_hubs = Hub.nested_set.roots.published

    sub_sql = PubCategoryRel
                .published
                .where(category: @hub)
                .select(%{ DISTINCT ON ("item_id", "item_type") * })
                .to_sql

    @pub_items = PubCategoryRel
                  .from("(#{ sub_sql }) pub_category_rels")
                  .includes(:item)
                  .max2min([:id])
                  .simple_sort(params)
                  .pagination(params)
  end

  # =======================================
  # Restricted Area | Admin
  # =======================================

  def manage
    sub_sql = PubCategoryRel
                .for_manage
                .select(%{ DISTINCT ON ("item_id", "item_type") * })
                .to_sql

    @pub_items = PubCategoryRel
                  .from("(#{ sub_sql }) pub_category_rels")
                  .includes(:item)
                  .max2min([:id])
                  .simple_sort(params)
                  .pagination(params)
  end
end