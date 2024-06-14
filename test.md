{% assign pdf_files = site.static_files | where: "extname", ".pdf" %}

<ul>
{% for file in pdf_files %}
    <li> {{file.name}} </li>
{% endfor %}
</ul>

<ul>
{% for file in site.pages %}
    {% if file.path contains 'SLIDES' %}
        {% if file.path contains 'vignette' %}
            {% unless file.path contains 'FIGS' %}
                {% if file.path contains 'qmd' %}
                    {% assign pdf_version_exists = false %}
                    {% assign file_name_with_pdf = {{ file.name | remove: ".qmd" }}.pdf %}
                    {% for pdf_file in pdf_files %}
                        {% if pdf_file.name == file_name_with_pdf %}
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
    {% endif %}
{% endfor %}
</ul>
