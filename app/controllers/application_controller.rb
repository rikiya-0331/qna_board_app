# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :_set_common_meta_tags

  private

  def _set_common_meta_tags
    site_name = 'Q&A Board App'
    default_title = 'Q&A Board App - 質問と回答で知識を共有'
    description = 'Q&A Board Appは、様々な質問と回答を通じて知識を共有し、学びを深めるためのプラットフォームです。'
    keywords = 'Q&A, 質問, 回答, 知識共有, 学習, プログラミング, 英語'
    ogp_image = view_context.image_url('ogp_default.png') # asset_pathではなくimage_urlを使用

    set_meta_tags(
      site: site_name,
      title: default_title,
      description: description,
      keywords: keywords,
      og: {
        title: default_title,
        type: 'website',
        url: request.original_url,
        image: ogp_image,
        site_name: site_name,
        description: description
      },
      twitter: {
        card: 'summary_large_image', # または 'summary'
        site: '@ynYo87UW6s10979', # あなたのTwitterアカウントがあれば設定
        title: default_title,
        description: description,
        image: ogp_image
      }
    )
  end
end
