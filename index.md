## R for modellers

These are slides, code and links to videos related to the use of the `R` programming language. This information is mainly geared towards mathematical modellers. However, you will also find this useful if you are registered in one of the courses I teach at the University of Manitoba in which I require coding.

On the [GitHub version](https://github.com/julien-arino/R-for-modellers/) of the page, you have access to all the files. You can also download the entire repository by clicking the buttons on the left. (You can also of course clone this repo, but you will need to do that from the GitHub version of the site.)

Feel free to use the material in these slides or in the folders. If you find this useful, I will be happy to know. Slides are produced mostly using [Marp](https://marp.app/), with a few using other systems ($\LaTeX$, Sweave, Rmarkdown, etc.).

### Slides

Please note that at present, the slides are work in progress. I will be updating them as the course progresses.

<ul>
{% for file in site.static_files %}
  {% if file.path contains 'SLIDES' %}
    {% if file.path contains 'lecture' %}
      {% if file.path contains 'pdf' %}
        {% unless file.path contains 'FIGS' %}
          <li><a href="https://julien-arino.github.io/R-for-modellers/SLIDES/{{ file.basename }}.pdf">{{ file.basename }}</a></li>
        {% endunless %}
      {% endif %}
    {% endif %}
  {% endif %}
{% endfor %}
</ul>

At present, there are no videos. I will be recording videos when time permits, probably in early 2024.