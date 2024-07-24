function displayMastodonComments(data) {
  const commentsList = document.getElementById('mastodon-comments-list');
  commentsList.innerHTML = ""; // Clear existing comments

  data.descendants.forEach(function(reply) {
    if (reply.visibility == "public") {
      const commentDiv = document.createElement('div');
      commentDiv.className = 'mastodon-comment';
      
      const username = reply.account.acct || reply.account.username;
      
      commentDiv.innerHTML = `
        <img class="comment-avatar" src="${escapeHtml(reply.account.avatar_static)}" alt="Avatar">
        <div class="comment-content">
          <div class="comment-header">
            <div class="user-info">
              <span class="display-name">${escapeHtml(reply.account.display_name)}</span>
              <span class="username">@${escapeHtml(username)}</span>
            </div>
            <span class="comment-date">${formatDate(reply.created_at)}</span>
          </div>
          <div class="comment-text">${reply.content}</div>
          <div class="comment-actions">
            <span class="comment-action">↩ ${reply.replies_count}</span>
            <span class="comment-action">🔁 ${reply.reblogs_count}</span>
            <span class="comment-action">⭐ ${reply.favourites_count}</span>
          </div>
        </div>
      `;

      commentsList.appendChild(commentDiv);
    };
  });
}

function escapeHtml(unsafe) {
  return unsafe
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;")
    .replace(/'/g, "&#039;");
}

function formatDate(dateString) {
  const date = new Date(dateString);
  const now = new Date();
  const diffHours = Math.floor((now - date) / (1000 * 60 * 60));
  
  if (diffHours < 24) {
    return `${diffHours}h`;
  } else {
    return date.toLocaleDateString('en-US', { month: 'short', day: 'numeric' });
  }
}

// Expose the function to the global scope
window.loadMastodonComments = function(commentsHost, commentsId) {
  document.getElementById("load-comment").innerHTML = "Loading";
  fetch(`https://${commentsHost}/api/v1/statuses/${commentsId}/context`)
    .then(function(response) {
      return response.json();
    })
    .then(displayMastodonComments);
}
