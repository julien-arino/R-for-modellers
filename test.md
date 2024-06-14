{% assign pdf_files = site.static_files | where: "extname", ".pdf" %}
{% assign qmd_files = site.pages | where_exp: "page", "page.path contains '.qmd'" %}

<ul>
{% for file in pdf_files %}
    <li> {{file.name | remove: ".pdf" }} </li>
{% endfor %}
</ul>

<ul>
{% for qmd_file in qmd_files %}
    <li> {{qmd_file.name | remove: ".qmd" }} </li>
    {% assign q_file = {{qmd_file.name | remove: ".qmd" }} %}
    {% for pdf_file in pdf_files %}
        {% assign q_file = {{pdf_file.name | remove: ".pdf" }} %}
        {% if  p_file == q_file %}
            <li> Eureka!!!!! </li>
        {% endif %}
    {% endfor %}
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

<ul>
{% for file in qmd_files %}
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
{% endfor %}
</ul>

