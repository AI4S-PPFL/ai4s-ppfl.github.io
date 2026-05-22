---
layout: default
title: Highlights
---

<!-- Hero Header Section -->
<section class="hero-header" id="home">
  <div class="hero-overlay"></div>
  <div class="hero-content container">
    <h2 class="hero-title">Privacy-Preserving Federated Learning for Science</h2>
  </div>
</section>

<div class="content-block">

<p class="body-text">
  The following slides contain highlights of recent scientific achievements:
</p>

{% assign highlights_sorted = site.data.highlights | sort: "file" | reverse %}
<ul class="body-list">
{% for h in highlights_sorted -%}
    <li><strong>{{ h.date | date: "%b %-d, %Y" }}</strong> — <a href="{{ site.baseurl }}/highlights/{{ h.file | uri_escape }}" target="_blank">{{ h.title }}</a></li>
{% endfor -%}
</ul>

</div>
