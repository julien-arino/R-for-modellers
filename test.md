{% assign pdf_files = site.static_files | where: "extname", ".pdf" %}
{% assign qmd_files = site.static_files | where: "extname", ".qmd" %}

<ul>
{% for file in pdf_files %}
    <li> {{file.name}} </li>
{% endfor %}
</ul>

<ul>
{% for file in qmd_files %}
    <li> {{file.name}} </li>
{% endfor %}
</ul>

<ul>
{% for file in site.pages %}
    {% if file.path contains 'SLIDES/vignette' %}
        {% unless file.path contains 'FIGS' %}
            {% if file.path contains 'qmd' %}
                {% assign pdf_version_exists = false %}
                {% assign file_name_with_pdf = {{ file.name | remove: ".qmd" }}.pdf %}
                {% assign file_name_with_pdf = {{ file.basename }} %}
                {% for pdf_file in pdf_files %}
                    {% if pdf_file.basename == file_name_with_pdf %}
                        {% assign pdf_version_exists = true %}
                    {% endif %}
                {% endfor %}
                {% if pdf_version_exists %} 
                    <li><a href="https://julien-arino.github.io/R-for-modellers/SLIDES/{{ file.name | remove: ".qmd" }}.pdf">{{ file.long-title }}</a>
                {% else %}
                    <li><a href="https://julien-arino.github.io/R-for-modellers/SLIDES/{{ file.name | remove: ".qmd" }}.html">{{ file.long-title }}</a>
                {% endif %}
                {% if file.youtube %}
                    <a href="{{ file.youtube }}"><img src="assets/img/yt_logo_rgb_light.png" height="15px" /></a>
                {% endif %}
                </li>
            {% endif %}
        {% endunless %}
    {% endif %}
{% endfor %}
</ul>


<h2>Available Documents</h2>
<ul>
{% for file in site.static_files %}
  {% assign base_name = file.basename | split: '.' | first %}
  {% assign html_file = site.static_files | where: "basename", base_name + '.html' | first %}
  {% assign pdf_file = site.static_files | where: "basename", base_name + '.pdf' | first %}

    {% if file.path contains 'SLIDES/vignette' %}
    {% unless file.path contains 'FIGS' %}
  {% if pdf_file %}
    <li><a href="{{ pdf_file.path }}">{{ pdf_file.basename }}</a></li>
  {% elsif html_file %}
    <li><a href="{{ html_file.path }}">{{ html_file.basename }}</a></li>
  {% endif %}
  {% endunless %}
  {% endif %}
{% endfor %}
</ul>