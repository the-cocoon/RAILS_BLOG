# ::ThinkingSphinx.search("canon", star: true, indices: %w[ product_core ]).count
# ::ThinkingSphinx.search("canon", star: true, indices: %w[ admin_product_core ]).count

# ::ThinkingSphinx.search("canon", star: true, classes: [ Product ], indices: %w[ product_core ]).count
# ::ThinkingSphinx.search("canon", star: true, classes: [ Product ], indices: %w[ admin_product_core ]).count

class PubsSearchController < RailsBlogController
  skip_before_filter :authenticate_user!,   only: %w[ pubs_search ]
  skip_before_filter :blog_admin_required!, only: %w[ pubs_search ]
  skip_before_filter :owner_required,       only: %w[ pubs_search ]

  def pubs_search
    @bq = params[:bq].to_s.strip
    to_search = ::Riddle::Query.escape @bq

    # with star
    @blog_items_0 = ::ThinkingSphinx.search(
      to_search,
      star: true,
      classes: [ Post ],
      field_weights: {
        fts_manual_data: 10,
        fts_auto_data: 7,
        title: 5,
        content: 3
      },
      per_page: 24
    )

    # without star
    @blog_items_1 = ::ThinkingSphinx.search(
      to_search,
      star: false,
      classes: [ Post ],
      field_weights: { title: 10, content: 5 },
      per_page: 24
    )

    @pub_items = (@blog_items_0.count > @blog_items_1.count) ? \
                   @blog_items_0 : \
                   @blog_items_1

    respond_to do |format|
      format.html { render layout: 'rails_blog_frontend' }
      format.json { render template: 'rails_blog/pubs_search/json/pubs_search.json.jbuilder' }
    end
  end
end