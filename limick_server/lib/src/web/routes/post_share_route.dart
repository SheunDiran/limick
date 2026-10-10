import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../../generated/protocol.dart';

/// Renders a shareable, SEO-friendly HTML preview page for a post at `/p/:id`.
/// Includes OpenGraph and Twitter card metadata so links unfurl beautifully on
/// social platforms and messaging apps, with a direct link to open the app.
class PostShareRoute extends Route {
  static const _idParam = IntPathParam(#id);

  @override
  Future<Result> handleCall(Session session, Request request) async {
    int? postId;
    try {
      postId = request.pathParameters.get(_idParam);
    } catch (_) {
      final raw = request.pathParameters.raw[#id] ??
          request.pathParameters.raw['id'];
      if (raw != null) postId = int.tryParse(raw.toString());
    }

    if (postId == null) {
      return Response.notFound(
        body: Body.fromString('Post not found', mimeType: MimeType.plainText),
      );
    }

    final post = await Post.db.findById(session, postId);
    if (post == null) {
      return Response.notFound(
        body: Body.fromString(
          _notFoundHtml(postId),
          mimeType: MimeType.html,
        ),
      );
    }

    final book = await Book.db.findById(session, post.bookId);
    final chapter = await Chapter.db.findById(session, post.chapterId);
    final html = _buildHtml(post, book, chapter);

    return Response.ok(
      body: Body.fromString(html, mimeType: MimeType.html),
    );
  }

  static String _escape(String text) => const HtmlEscape().convert(text);

  static String _notFoundHtml(int id) {
    return '''<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Post Not Found · Limick</title>
  <style>
    body {
      background: #0D0D0F;
      color: #EDE7DC;
      font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
      display: flex;
      align-items: center;
      justify-content: center;
      min-height: 100vh;
      margin: 0;
      text-align: center;
      padding: 24px;
    }
    .card { max-width: 420px; }
    h1 { font-size: 24px; margin-bottom: 8px; }
    p { color: #9C978F; line-height: 1.5; }
    a {
      display: inline-block;
      margin-top: 16px;
      padding: 12px 24px;
      background: #EDE7DC;
      color: #0D0D0F;
      text-decoration: none;
      border-radius: 12px;
      font-weight: 600;
    }
  </style>
</head>
<body>
  <div class="card">
    <h1>Post not found</h1>
    <p>Post #$id may have been removed or does not exist.</p>
    <a href="/app">Open Limick</a>
  </div>
</body>
</html>''';
  }

  static String _buildHtml(Post post, Book? book, Chapter? chapter) {
    final bookTitle = book?.title ?? 'Classic Literature';
    final author = book?.author ?? 'Public Domain';
    final handle = book?.handle ?? 'limick';
    final excerpt = post.quote ?? post.body;
    final title = '${_escape(bookTitle)} on Limick';
    final description = _escape(
      excerpt.length > 200 ? '${excerpt.substring(0, 197)}...' : excerpt,
    );
    final escapedBody = _escape(post.body);
    final escapedQuote = post.quote != null ? _escape(post.quote!) : null;

    final kindName = post.kind.name.toUpperCase();
    final chapterTitle = chapter != null ? _escape(chapter.title) : '';

    return '''<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>$title</title>
  <meta name="description" content="$description">

  <!-- OpenGraph -->
  <meta property="og:title" content="$title">
  <meta property="og:description" content="$description">
  <meta property="og:type" content="article">
  <meta property="og:site_name" content="Limick">

  <!-- Twitter Card -->
  <meta name="twitter:card" content="summary">
  <meta name="twitter:title" content="$title">
  <meta name="twitter:description" content="$description">

  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Instrument+Sans:wght@400;500;600;700&family=Newsreader:ital,opsz,wght@0,6..72,400;0,6..72,500;0,6..72,600;1,6..72,400&display=swap" rel="stylesheet">

  <style>
    :root {
      --bg: #0D0D0F;
      --surface: #151518;
      --raised: #1D1D21;
      --ink: #EDE7DC;
      --muted: #9C978F;
      --faint: #8A857E;
      --line: #26262B;
      --accent: #FF6A3D;
      --font-sans: 'Instrument Sans', -apple-system, BlinkMacSystemFont, sans-serif;
      --font-serif: 'Newsreader', Georgia, serif;
    }

    @media (prefers-color-scheme: light) {
      :root {
        --bg: #F7F2E9;
        --surface: #FFFCF6;
        --raised: #EFE8DB;
        --ink: #1A1714;
        --muted: #6E675E;
        --faint: #756E63;
        --line: #E3DACB;
        --accent: #E2471B;
      }
    }

    * { box-sizing: border-box; margin: 0; padding: 0; }
    body {
      background: var(--bg);
      color: var(--ink);
      font-family: var(--font-sans);
      min-height: 100vh;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      padding: 24px 16px;
      line-height: 1.5;
    }

    .container {
      width: 100%;
      max-width: 580px;
    }

    .header {
      display: flex;
      align-items: center;
      justify-content: space-between;
      margin-bottom: 20px;
    }

    .brand {
      display: flex;
      align-items: center;
      gap: 8px;
      text-decoration: none;
      color: var(--ink);
      font-weight: 700;
      font-size: 18px;
      letter-spacing: -0.3px;
    }

    .brand-flame {
      color: var(--accent);
      font-size: 20px;
    }

    .post-card {
      background: var(--surface);
      border: 1px solid var(--line);
      border-radius: 20px;
      padding: 28px 24px;
      box-shadow: 0 12px 36px rgba(0, 0, 0, 0.25);
    }

    .post-header {
      display: flex;
      align-items: center;
      justify-content: space-between;
      margin-bottom: 18px;
    }

    .author-info {
      display: flex;
      flex-direction: column;
    }

    .author-title {
      font-family: var(--font-serif);
      font-weight: 600;
      font-size: 17px;
      color: var(--ink);
    }

    .author-meta {
      font-size: 13px;
      color: var(--muted);
    }

    .kind-badge {
      font-size: 11px;
      font-weight: 700;
      letter-spacing: 1.5px;
      color: var(--accent);
      background: var(--raised);
      padding: 4px 10px;
      border-radius: 99px;
    }

    .quote-box {
      border-left: 2px solid var(--accent);
      padding: 6px 0 6px 16px;
      margin: 16px 0;
      font-family: var(--font-serif);
      font-size: 19px;
      font-style: italic;
      line-height: 1.45;
      color: var(--ink);
    }

    .body-text {
      font-family: var(--font-serif);
      font-size: 20px;
      line-height: 1.35;
      color: var(--ink);
      margin-bottom: 12px;
    }

    .word-box {
      background: var(--raised);
      border-radius: 14px;
      padding: 18px;
      margin: 16px 0;
    }

    .word-title {
      font-family: var(--font-serif);
      font-size: 26px;
      font-weight: 600;
      color: var(--ink);
    }

    .word-pos {
      font-family: var(--font-serif);
      font-style: italic;
      font-size: 15px;
      color: var(--muted);
      margin-left: 8px;
    }

    .word-def {
      font-size: 15px;
      margin-top: 6px;
      color: var(--ink);
    }

    .chapter-tag {
      font-size: 12px;
      color: var(--faint);
      margin-top: 14px;
      display: flex;
      align-items: center;
      gap: 6px;
    }

    .cta-row {
      margin-top: 24px;
      display: flex;
      gap: 12px;
    }

    .cta-btn {
      flex: 1;
      display: inline-flex;
      align-items: center;
      justify-content: center;
      padding: 14px 20px;
      background: var(--ink);
      color: var(--bg);
      text-decoration: none;
      font-weight: 600;
      font-size: 15px;
      border-radius: 14px;
      transition: opacity 0.2s;
    }
    .cta-btn:hover { opacity: 0.9; }

    .footer {
      margin-top: 24px;
      text-align: center;
      font-size: 13px;
      color: var(--muted);
    }
    .footer a { color: var(--muted); text-decoration: underline; }
  </style>
</head>
<body>
  <div class="container">
    <div class="header">
      <a href="/app" class="brand">
        <span class="brand-flame">✦</span>
        <span>Limick</span>
      </a>
      <span class="author-meta">Public-domain classics</span>
    </div>

    <div class="post-card">
      <div class="post-header">
        <div class="author-info">
          <div class="author-title">${_escape(bookTitle)}</div>
          <div class="author-meta">by ${_escape(author)} · @$handle</div>
        </div>
        <div class="kind-badge">$kindName</div>
      </div>

      ${post.kind == PostKind.word && post.word != null ? '''
        <div class="word-box">
          <div>
            <span class="word-title">${_escape(post.word!)}</span>
            ${post.wordPartOfSpeech != null ? '<span class="word-pos">${_escape(post.wordPartOfSpeech!)}</span>' : ''}
          </div>
          ${post.wordDefinition != null ? '<div class="word-def">${_escape(post.wordDefinition!)}</div>' : ''}
        </div>
      ''' : ''}

      ${escapedQuote != null ? '<div class="quote-box">“$escapedQuote”</div>' : ''}

      <div class="body-text">$escapedBody</div>

      ${chapterTitle.isNotEmpty ? '<div class="chapter-tag">📖 $chapterTitle</div>' : ''}

      <div class="cta-row">
        <a href="/app" class="cta-btn">Open in Limick App</a>
      </div>
    </div>

    <div class="footer">
      Every post on Limick is grounded in a real <a href="https://www.gutenberg.org" target="_blank" rel="noopener">Project Gutenberg</a> book.
    </div>
  </div>
</body>
</html>''';
  }
}
