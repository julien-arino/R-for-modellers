{% assign pdf_files = site.static_files | where: "extname", ".pdf" %}
{% assign qmd_files = site.pages | where_exp: "page", "page.path contains '.qmd'" %}

<ul>
{% for pdf_file in pdf_files %}
    <li> {{ pdf_file.name | remove: ".pdf" }} </li>
    {% capture p_file %} {{ pdf_file.name | remove: ".pdf" }} {% endcapture %}
    <li> {{ p_file }} <li>
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
{% for qmd_file in qmd_files %}
    <li> {{ qmd_file.name | remove: ".qmd" }} </li>
    {% capture q_file %}  {{ qmd_file.name | remove: ".qmd" }} {% endcapture %}
    <li> {{ q_file }} </li>
    {% for pdf_file in pdf_files %}
        {% capture p_file %} {{ pdf_file.name | remove: ".pdf" }} {% endcapture %}
        {% if p_file == q_file %}
            <li> Eureka!!!!! </li>
        {% endif %}
    {% endfor %}
{% endfor %}
</ul>

<ul>
{% for qmd_file in qmd_files %}
    {% capture q_file %}  {{ qmd_file.name | remove: ".qmd" }} {% endcapture %}
    <li><a href="https://julien-arino.github.io/R-for-modellers/SLIDES/{{ qmd_file.name | remove: ".qmd" }}.html">{{ qmd_file.long-title }}</a>
    <li><a href="https://julien-arino.github.io/R-for-modellers/SLIDES/{{ q_file }}.html">{{ qmd_file.long-title }}</a>
    {% for pdf_file in pdf_files %}
        {% capture p_file %} {{ pdf_file.name | remove: ".pdf" }} {% endcapture %}
        <li>p_file: {{ p_file }}</li>
        {% if p_file == q_file %}
            <li> Eureka!!!!! </li>
        {% endif %}
    {% endfor %}
    {% if qmd_file.youtube %}
        <a href="{{ qmd_file.youtube }}"><img src="assets/img/yt_logo_rgb_light.png" height="15px" /></a>
    {% endif %}
    </li>
{% endfor %}
</ul>

