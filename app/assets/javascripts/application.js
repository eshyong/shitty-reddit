//= require jquery3
//= require jquery_ujs
//= require_tree .

const showReplyForm = (commentId) => {
  $(`#reply-form-${commentId}`).first().show();
};

$(document).ready(() => {
});

