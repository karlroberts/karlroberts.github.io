---
published: true
layout: post
title: "The Rise and (hopefully) fall of the Aux Pattern"
date: 2017-01-31 08:36:16 +1100
comments: true
paginate:
  collection:   auxpattern
  per_page:     10             # maximum number of items per page
  limit:        5   
categories: 
---
kjdfhkjsdfsdfjk
dfkjsdfjn

{% for post in paginator.auxpattern %}
  this is foobar page num is {{ paginator.page }} of 

bble
paginator.total_pages {{  paginator.total_pages }}
paginator.total_posts {{  paginator.total_posts }}
paginator.per_page {{  paginator.per_page }}
 {{  paginator.limit }}
 {{  paginator.page }}
 {{  paginator.previous_page }}
 {{  paginator.previous_page_path }}
 {{  paginator.next_page }}
 {{  paginator.next_page_path }}

{% endfor %}

{% if paginator.total_pages > 1 %}
<div class="pagination">
  {% if paginator.previous_page %}
    <a href="{{ paginator.previous_page_path | prepend: site.baseurl | replace: '//', '/' }}">&laquo; Prev</a>
  {% else %}
    <span>&laquo; Prev</span>
  {% endif %}

  {% for page in (1..paginator.total_pages) %}
    {% if page == paginator.page %}
      <em>{{ page }}</em>
    {% elsif page == 1 %}
       <a href="{{ '/index.html' | prepend: site.baseurl | replace: '//', '/' }}">{{ page }}</a>
    {% else %}
       <a href="{{ site.paginate_path | prepend: site.baseurl | replace: '//', '/' | replace: ':num', page }}">{{ page }}</a>
    {% endif %}
  {% endfor %}

  {% if paginator.next_page %}
     <a href="{{ paginator.next_page_path | prepend: site.baseurl | replace: '//', '/' }}">Next &raquo;</a>
  {% else %}
     <span>Next &raquo;</span>
  {% endif %}
     </div>
{% endif %}

Foo bar page 1 auxpattern



<!-- Pagination links -->
<div class="pagination">
  {% if paginator.previous_page %}
    <a href="{{ paginator.previous_page_path }}" class="previous">Previous</a>
  {% else %}
    <span class="previous">Previous</span>
  {% endif %}
  <span class="page_number ">Page: {{ paginator.page }} of {{ paginator.total_pages }}</span>
 {% if paginator.next_page %}
    <a href="{{ paginator.next_page_path }}" class="next">Next</a>
 {% else %}
    <span class="next ">Next</span>
 {% endif %}
</div>
