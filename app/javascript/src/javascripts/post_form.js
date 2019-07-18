$(function() {
  // ---------- submitボタン 有効/無効 切替 ----------
  $("#button-post").prop("disabled", true); //初期値：disabled

  const judgeMent = function(data) {
    if (data) {
      //有効化
      $("#button-post")
        .prop("disabled", false)
        .removeClass("disabled");
      $(".dummy-submit-btn").attr("id", "dummy-submit-btn");
    } else {
      //無効化
      $("#button-post")
        .prop("disabled", true)
        .addClass("disabled");
      $(".dummy-submit-btn").attr("id", "");
    }
  };

  // ----- ３ジャンル共通 -----
  $(document).on("keyup", "#post_content, #post_link_url", function() {
    const genre = $("#post-genre").val();
    const contentVal = $("#post_content").val();
    const linkVal = $("#post_link_url").val();
    const rankVal = $('input[name="post[book_evaluation]"]:checked').val();

    switch (genre) {
      case "book":
        judgeMent(contentVal && linkVal && rankVal);
        break;
      case "article":
        judgeMent(contentVal && linkVal);
        break;
      case "other":
        judgeMent(contentVal);
        break;
    }
  });

  // ----- bookジャンル -----
  $(document).on("change", 'input[name="post[book_evaluation]"]', function() {
    const genre = $("#post-genre").val();
    const contentVal = $("#post_content").val();
    const linkVal = $("#post_link_url").val();
    const rankVal = $('input[name="post[book_evaluation]"]:checked').val();
    if (genre === "book") {
      judgeMent(contentVal && linkVal && rankVal);
    }
  });

  $(document).on("change", "#post_link_url", function() {
    const genre = $("#post-genre").val();
    const contentVal = $("#post_content").val();
    const linkVal = $("#post_link_url").val();
    const rankVal = $('input[name="post[book_evaluation]"]:checked').val();
    if (genre === "book") {
      judgeMent(contentVal && linkVal && rankVal);
    }
  });

  // ---------- 本検索結果選択 ----------
  $(document).on("click", ".book-list__item", function() {
    let element = $(this).html();
    $("#book-select-result").html(element);
    let bookImg = $(this)
      .find("img")
      .prop("src");
    let bookTitle = $(this)
      .find("span")
      .text();
    let bookLink = $(this)
      .find("input")
      .val();
    $("#post_link_url")
      .val(bookLink)
      .change();
    $("#post_link_title").val(bookTitle);
    $("#post_link_image").val(bookImg);
    $(".book-list__item").hide();
  });
});
