{% assign pdf_files = site.static_files | where: "extname", ".pdf" %}
{% assign qmd_files = site.pages | where_exp: "page", "page.path contains '.qmd'" %}

<ul>
{% for file in pdf_files %}
    <li> {{file.name | remove: ".pdf" }} </li>
{% endfor %}
</ul>

<ul>
{% for qmd_file in qmd_files %}
    <li> {{ qmd_file.name | remove: ".qmd" }} </li>
    {% assign q_file = {{ qmd_file.name | remove: ".qmd" }} %}
    <li> {{ q_file }} </li>
    {% for pdf_file in pdf_files %}
        {% assign p_file = {{ pdf_file.name | remove: ".pdf" }} %}
        {% if p_file == q_file %}
            <li> Eureka!!!!! </li>
        {% endif %}
    {% endfor %}
{% endfor %}
</ul>

<ul>
{% for file in qmd_files %}
    <li><a href="https://julien-arino.github.io/R-for-modellers/SLIDES/{{ file.name | remove: ".qmd" }}.html">{{ file.long-title }}</a>
    {% if file.youtube %}
        <a href="{{ file.youtube }}"><img src="assets/img/yt_logo_rgb_light.png" height="15px" /></a>
    {% endif %}
    </li>
{% endfor %}
</ul>

