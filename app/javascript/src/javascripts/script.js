$(function() {
  // ---------- Aboutページ cssリセット ----------
  const page = $("main").attr("data-page");
  if (page === "about-page") {
    $(".main-container").css("padding-top", 60);
    $(".footer").css("margin-top", 0);
  }

  // ---------- ハンバーガーメニュー ----------
  $(".nav-toggle").click(function() {
    $("#tab-menu").toggleClass("nav-open");

    if ($("#tab-menu-contents").hasClass("active")) {
      $("#tab-menu-contents").fadeOut(100);
      $("#tab-menu-contents").removeClass("active");
    } else {
      setTimeout(function() {
        $("#tab-menu-contents").fadeIn(500);
      }, 150);
      $("#tab-menu-contents").addClass("active");
    }
  });

  // ---------- ユーザーリンク ----------
  // ----- 表示/非表示 -----
  $("#user-icon").click(function() {
    $("#user-link").toggle();
  });
  // ----- 非表示(モーダル外をクリック) -----
  $(document).on("click touchend", function(event) {
    if (!$(event.target).closest("#user-icon").length) {
      $(this)
        .find("#user-link")
        .hide();
    }
  });

  // ---------- 検索ページ遷移(TABサイズ以下) ----------
  // ----- 表示 -----
  $("#sp-serch").click(function() {
    $("#serch-page").show();
  });
  // ----- 非表示 -----
  $("#serch-page-close").click(function() {
    $("#serch-page").hide();
  });

  // ---------- 画像アップロード レイアウト遷移 ----------
  $(document).on("change", ".image-form", function() {
    let over = []; // Filelist配列
    const data = $(this).data("id");
    const file = $(this).prop("files");
    const maximumFiles = 3;
    $(`.filename--${data}`).remove();
    if (file.length > maximumFiles) {
      alert("画像を3枚まで選択してください。");
      $(this).val(null);
    }

    Array.from(file).forEach(e => {
      const size = e.size / 1024 / 1024;
      const maximumSizes = 5;
      if (size > maximumSizes) {
        //ファイルサイズ5MBより上
        over.push("true");
        over_name = e.name;
        $(`.filename--${data}`).remove();
      } else {
        over.push("false");
        // 選択したファイル名を表示
        $(`#form-image--${data}`).append(
          `<span class="filename filename--${data}">・${e.name}</span>`
        );
        $(`#input-label--${data}`).addClass("changed");
      }
    });

    if (over.indexOf("true") >= 0) {
      //over配列に"true"が存在する
      alert(`画像サイズは5MB以内にしてくだい(${over_name}`);
      $(this).val(null);
      over = [];
    }
    // over配列をリセット
    over = [];
  });

  // ---------- ページ上部エラーメッセージ ----------
  setTimeout(function() {
    $("#alert").addClass("alert-down");
  }, 100);
  setTimeout(function() {
    $("#alert").removeClass("alert-down");
  }, 2500);

  //  ----------introduce文字制限 77文字以上に３点リーダー ----------
  $(".introduce-text").each(function(i, t) {
    const count = $(t).text().length;
    const maximumCharacters = 76;
    if (count > maximumCharacters) {
      $(this).addClass("active");
    }
  });

  // ---------- 投稿検索結果 一致する結果なし ----------
  const posts = $("#post-list--search").children();
  if (posts.length === 0) {
    const title = $("#search-title").text();
    $("#post-list--search").append(
      `<p class="failure-text">「${title}」に一致する検索結果はありません</p>`
    );
  }

  // ---------- 投稿メタリンク ----------
  // ----- 表示 -----
  $(document).on("click", ".post-meta-icon", function() {
    let dataId = $(this).attr("data-id");
    $(`#post-meta-${dataId}`).show();
  });
  // ----- 非表示(モーダル外をクリック) -----
  $(document).on("click touchend", function(event) {
    if (!$(event.target).closest(".post-meta-icon, .post-meta").length) {
      $(".post-meta").hide();
    }
  });

  // ---------- 投稿画像カルーセル ----------
  $(".post-list .slider").slick({
    dots: true
  });
});
