FactoryBot.define do
  factory :post do
    association :user  # Postがbelongs_to :user なので必要
    title { "タイトル" }
    content { "コンテンツ" }
    category { "アパレル" }
    price_range { "3000-4999円" }
    uv_cut_rate { "99.9%以上" }
    image { Rack::Test::UploadedFile.new(Rails.root.join("spec/fixtures/test_image.jpg"), "image/jpeg") }
  end
end
