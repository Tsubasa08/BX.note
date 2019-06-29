$(function() {
  //3ジャンから選択
  $(".label").click(function() {
    $.ajax({
      url: "/ajax",
      type: "get",
      dataType: "json"
    })
      .done(function(data) {
        // 投稿モーダル内 画像アップロード レイアウト遷移
        $("#panel-area").on("change", ".image-form", function() {
          const data = $(this).data("id");
          const file = $(this).prop("files");
          $(`.filename--${data}`).hide();
          Array.from(file).forEach(e => {
            $(`#form-image--${data}`).append(
              `<span class="filename filename--${data}">${e.name}</span>`
            );
            $(`#input-label--${data}`).addClass("changed");
          });
        });
      })
      .fail(function() {
        window.alert("読み込みエラー");
      });
  });
});
