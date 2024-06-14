# R for modellers

These small snapshots ("vignettes") illustrate techniques in `R`.
This information is mainly geared towards mathematical modellers but may be useful to others. 

If you are registered in one of the courses I teach at the University of Manitoba in which I require `R` coding, e.g., [Mathematics of Data Science (MATH 2740)](https://julien-arino.github.io/math-of-data-science/), some of the vignettes are required material.

Slides are produced using [Quarto](https://quarto.org/) and, for a few, using [Sweave](https://www.stat.ethz.ch/R-manual/R-devel/library/utils/doc/Sweave.pdf).
Slide sources and all the code used are available on the [GitHub repo](https://github.com/julien-arino/R-for-modellers/). Feel free to use any material; if you find this useful, I will be happy to know, that's all.

Material here is inherently work in progress. 
I will be updating the vignettes from time to time to reflect a better understanding of the material, new packages, etc. 
The vignettes and videos vary greatly in length.
Their order is not relevant and somewhat random.

When present, the YouTube logo points to the video of the vignette. Those vignettes for which a video is available are more complete than those without.

{% assign pdf_files = site.static_files | where: "extname", ".pdf" %}
{% assign qmd_files = site.pages | where_exp: "page", "page.path contains '.qmd'" %}

<ul>
{% for qmd_file in qmd_files %}
    {% capture q_file %}  {{ qmd_file.name | remove: ".qmd" }} {% endcapture %}
    <li><a href="https://julien-arino.github.io/R-for-modellers/SLIDES/{{ qmd_file.name | remove: ".qmd" }}.html">{{ qmd_file.long-title }}</a>
    {% if qmd_file.youtube %}
        <a href="{{ qmd_file.youtube }}"><img src="assets/img/yt_logo_rgb_light.png" height="15px" /></a>
    {% endif %}
    </li>
{% endfor %}
</ul>


## Note pour les étudiants francophones

Je prévois de traduire les vignettes en français, mais cela prendra du temps. En attendant, si vous avez des questions, n'hésitez pas à me contacter.
