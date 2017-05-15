defmodule UrlpreviewTest do
  use ExUnit.Case
  doctest Urlpreview

  @root_dir       File.cwd!
  @fixture_dir    Path.join(~w(#{@root_dir} test fixtures))

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "returns expected result" do
    preview = Urlpreview.Parser.parse(%{
      body: File.read!("#{@fixture_dir}/general_page.html"),
      request_url: "https://www.test-site.com",
      real_url: "https://www.test-site.com"
    })
    assert preview == %{
      real_url: "https://www.test-site.com",
      url: "https://www.test-site.com",
      description: "This is the meta description",
      images: [
        "https://www.test-site.com/itemprop_image.png",
        "https://www.test-site.com/itemprop_image2.png"
      ],
      title: "My Test Site"
    }
  end

  test "prioritizes og meta content above all other meta content" do
    preview = Urlpreview.Parser.parse(%{
      body: File.read!("#{@fixture_dir}/og_page.html"),
      request_url: "https://www.test-site.com",
      real_url: "https://www.test-site.com"
    })
    assert preview == %{
      real_url: "https://www.my-site-og-url.com/",
      url: "https://www.test-site.com",
      description: "Some OG:description.",
      images: [
        "https://og_image.jpg",
        "https://www.test-site.com/itemprop_image.png",
        "https://www.test-site.com/itemprop_image2.png"
      ],
      title: "My OG:Site Name"
    }
  end
end
