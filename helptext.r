############################
## UI part
printHTMLUI <- function(id) {
    ns <- NS(id)

    htmlOutput(ns("html"))

    ##htmlOutput(NS(id)("html"))
}


#############################
## server part
printHTML <- function(input, output, session, what, global.input=NULL, global.param=NULL){

    txt=''

    ## ##@#############################
    ## ## getting started
    if(what == 'gs'){
        txt=paste('<p><h3>Hello Proteomics Broadies!</h3><br><font size=\"4\">Welcome to <b>modT</b>, the Shiny-app that allows you to perform moderated versions of the <b>one-sample</b> and <b>two-sample T-tests</b> as well as <b>F-test</b> and to interactively explore the results. You can upload ratio reports generated by <b>Spectrum Mill</b> or any other kind of text file containing expression data and optional annotation columns.</font></p><br><br><br>')

        ## render HTML
        ##if(!is.null(error$msg) ) return()
        output$html <- renderText({
            ##if(!is.null((input$file))) return()
            if(!is.null(global.input$file)) return()
            HTML(txt)
        })
    }

    ##@###############################
    ## changelog
    if(what == 'cl'){
        txt=paste('<hr><p><font size=\"5\" color=\"red\">What\'s new:</font></p>',
'<font size=\"4\">
<b>v0.6.4</b>
<ul>
<li>Summary tab: number of significant hits are now reported correctly.</li>
<li>Summary tab: Missing value distribution after log-transformation shown correctly.</li>
<li>Changed cluster method from \'complete\' to \'ward\'.</li>
<li>Fixed a bug that happend if a project is defined and shared in \'user-roles.txt\' but has been deleted from the server.</li>
</ul>
<b>v0.6.3</b>
<ul>
<li>Commited to GitHub for debugging purposes. Do not use this verion!</li>
<li>Re-organization of UI elements when setting up the analysis.</li>
<li>Implementation of SD filter across all samples.</li>
</ul>
<b>v0.6.2</b>
<ul>
<li>UI elements for setting up an anlysis workflow are now dynamically generated, e.g. if reproducibility filter is chosen, onnly "One-sample modT" or "none" can be chosen.</li>
<li>Reproducibility filter: users can choose bewteen (predefined) alpha-values.</li>
<li>Increased number of colors by 60 (85 total).</li>
<li>Correlation matrix: increased the size of exported heatmap to 12x12 inches.</li>
<li>Multiscatter: increased number of digits to three.</li>
<li>Some more error handling when exporting analysis results.</li>
<li>Previously saved sessions are not deleted anymore, if checkbox "save session" is not enabled.</li>
</ul>
<b>v0.6.1</b>
<ul>
<li>Session managment: Added possibility to delete saved sessions and to choose whether to save a session on the server in the first place.</li>
<li>User role managment (alpha status): A project saved on the server has an owner and (optional) collaborators. Collaborators can \"see\" projects they are assigned to in the dropdown menu \"Saved sessions\".</li>
</ul>
<b>v0.6.0</b>
<ul>
<li>Switched to <a href="https://rstudio.github.io/shinydashboard/">Shiny Dashboards</a>.</li>
<li>Extented PCA analysis using the <i>ChemometricsWithR</i> R package.</li>
</ul>
<b>v0.5.4</b>
<ul>
<li>Filter values and plotting parameters are now restored after session import (except for volcano plot...).</li>
<li>Changed visual style of volcano plots.</li>
</ul>
<b>v0.5.3</b>
<ul>
<li>Minor fixes due to shiny update.</li>
<li>User can now specify label names used to create file and session names when  exporting results. Initial values are taken from filenames of the input and experimental design file.</li>
<li>Experimental design file is now part of the results.</li>
</ul>
<b>v0.5.2</b>
<ul>
<li>Rudimentary support of \'gct\' files, i.e. files can be imported by ignoring the first two lines (gct header). </li>
<li>Figured out the issue with  the 2-sample T-test volcanos. The functions in \'limma\' always report fold changes group factor variable \'0\'. The original \'moderated.t\' alphabetically orders the class names and then converts class names to factors. First class name will become zero. I make sure that class names are alphabeticaly sorted before calling \'moderated.t\'.</li>
</ul>
<b>v0.5.1</b>
<ul>
<li><mark>BUG: </mark>Reverted the indication of direction in volcano plots for <b>2-sample tests</b>. The direction was inferred from the sign of \'logFC\' returned by function \'topTable\' (limma) which cannot be used to do that.</li>
<li>Updated shiny R package from 0.12/0.13.2 to 0.14.2 resulting in some minor changes in the <i>look and feel</i> of the app. Code needed some adaptions (navbarPage, navbarMenu) to run poperly with 0.14.2 version.</li>
<li>Outsourced HTML instructions to a separate file using Shiny-module framework.</li>
<li>Changed how heatmap dimensions are determined to better show very large and very small heatmaps.</li>
<li>Scaling of heatmap done after clustering.</li>
</ul>
<b>v0.5.0</b>
<ul>
<li>Exported sessions are saved on the server and can be re-imported. Each user has its own folder on ther server in which an R-sessions file is stored.</li>
<li>Non-unique entries in the id column are made unique, e.g. \'Abl\', \'Abl\' -> \'Abl\', \'Abl_1\'. Empty entries will be replaced by \'X\', e.g. \'Abl\', \'\', \'\' -> \'Abl\', \'X\', \'X_1\'.</li>
</ul>
<b>v0.4.5</b>
<ul>
<li>Multiscatter: log-transformed values wil be used if log-transformation has been applied.</li>
<li>For each user a new folder on the server is created. Every session that gets exported will be saved there.</li>
<li>A copy of the original data file will be part of the results (zip-file).</li>
</ul>
<b>v0.4.4</b>
<ul>
<li>New \'Export\'-tab to download a zip-file containing:
 <ul>
   <li>all figures (pdf).</li>
   <li>result table (xlsx).</li>
   <li>session file (Rdata) which can be imported back into the app.</li>
   <li>parameter file (txt)</li>
 </ul>
<li>Directionality of two-sample test is now indicated in the volcano plots.</li>
<li>Error handling for two-component normalization.</li>
<li>Profile plots under \'QC\'-tab</li>
</ul>
<b>v0.4.3</b>
<ul>
<li>Session export/import.</li>
<li>"#VALUE!"-entries from Excel can be handeled now.</li>
<li>Fixed bug causing PDF export of heatmap with user defined max. values to crash.</li>
</ul>
<b>v0.4.2</b>
<ul>
<li><mark>BUG:</mark> Bugfix in 2-sample test that occured whenever the names of different groups defined the experimental design file started with the same series of characters, e.g. \'ABC\' and \'ABCD\'.</li>
</ul>
<b>v0.4.1</b>
<ul>
<li>Novel tab summarizing the analysis.</i>
<li>Data can now be log-transformed, e.g. for MaxQuant results.</li>
<li>Added option to skip testing, e.g. for PCA analysis.</li>
<li>User can specify principle components in the PCA scatterplot.</li>
</ul>
<b>v0.4</b>
<ul>
<li>Integration of moderated F statistics</li>
<li>Disabled column-based clustering one-sample and two-sample tests if multiple groups are being compared.</li>
</ul>
<b>v0.3</b>
<ul>
<li>Data normalization.</li>
<li>Reproducibility filter.</li>
<li>Upload/download of experimental design files.</li>
<li>Download of native Excel files.</li>
<li>Integration of the Javascript D3-based plotly library.</li>
</ul>
<b>v0.1</b>
<ul>
<li>First prototype.</li>
</ul>
</font>'
,sep='')

        ## render HTML
        output$html <- renderText({
            if(!is.null(global.input$file)) return()

            HTML(txt)
        })
    }

    ##@#########################################
    ## id column / exp design template
    if(what == 'id'){

        txt <- paste('<br><br><p><font size=\"4\"><b>Group assigment</b></br>
Here you can download a template of an experimental design file. You can open this file in Excel and define the groups you want to compare. Replicate measurements have to be grouped under a single name in the \'Experiment\'-column. Please avoid any special character when defining these names!</font></p>
<br><p><font size=\"4\"><b>Pick id column</b></br>
Choose a column from the list on the left that contains <b>unique</b> identifiers for the features in the data table. If the enntries are not unique, uniqueness will enforces by appending \"_1\". If the entries start with an UniProt accession, volcano plots and result table will contain direct links to the UniProt website.
</font></p>')

        ## render HTML
        output$html <- renderText({

            if(global.param$analysis.run) return()

            ##if(!is.null(error$msg) ) return()
            ##if(is.null(input$id.col)) return()
            ##if(input$id.col > 0 && !is.null(input$id.col.value)) return()
            if(is.null(global.input$id.col)) return() ## start page

            if(global.input$id.col > 0 && !is.null(global.param$id.col.value)) return() ## after id column is choosen

            HTML(txt)
        })
    }
    #####################################################################
    ## upload of experimental design file
    if(what == 'ed'){

        txt <- paste('<br><br><p><font size=\"4\">Please upload the experimental design file that you have created using the upload button on the left.</p></font></p>')

        ## render HTML
        output$html <- renderText({

            if(global.param$analysis.run) return()

            ##if( !is.null(error$msg) ) return()

            if(is.null(global.input$id.col)) return()
            if(global.input$id.col ==0) return()
            if(global.param$grp.done == T) return()

            HTML(txt)
        })
    }

    ## ####################################################################
    ## analysis
    if(what == 'ana'){

        txt <- paste('<font size=\"4\">
<p><h3>Log-transformation</h3>Apply log transformation to the data.</p>
<p><h3>Data normalization</h3>You can apply different normalization methods to the data prior to testing. The methods are applied for each column separately, except for \'Quantile\'-normalization which takes the entire matrix into account.</p>
<p>
<ul>
<li><b>Median</b>: Substract the sample median from each value.</li>
<li><b>Median-MAD</b>: Substract the sample median and divide by sample MAD.</li>
<li><b>2-component</b>: Use a mixture-model approach to separate non-changing from changing features and divide both populations by the median of the non-changing features.</li>
<li><b>Quantile</b>: Transform the data such that the quantiles of all sample distributions are the equal.</li>
<li><b>none</b>: The data will be taken as is. Should be used if the data has been already normalized.</li>
</ul>
<br><p><h3>Reproducibility filter</h3>This option is only considered in a <b>one-sample test</b> and will be ignored otherwise. For duplicate measurements a Bland-Altman Filter of 99.9% (+/-3.29 sigma) will be applied. For more than two replicate measurements per group a generalized reproducibility filter is applied which is based on a linear mixed effects model to model the within-group variance and between-group variance (See \'MethComp book (pp 58-61). <i>Comparing Clinical Measurement Methods</i> by Bendix Carstensen\' for more details). You can inspect the results of the filtering step in the multiscatter plot under the \'QC\'-tab. Data points removed prior to testing will be depicted in red.</p>

<br><h3>Select test</h3>You can choose between a one-sample, two-sample moderate T-tests, moderated F-test or no testing.
<ul>
<li><b>One-sample mod T</b>: For each test whether the group mean is significantly different from zero. Only meaningful to <b>ratio data</b>!</li>
<li><b>Two-sample mod T</b>: For each possible pairwise comparison of groups test whether the group means are significantly different from each other.</li>
<li><b>mod F</b>: Test whether there is a significant difference between any of the difined groups. Should be used if more than 2 groups are being compared. Only meaningful to <b>ratio data</b>!</li>
<li><b>none</b>: Don\'t do any test. Useful for data exploration such as PCA.</li>
</ul>
<br></font></p>')

        ## render HTML
        output$html <- renderText({
             if(global.param$analysis.run) return()
##             if( !is.null(error$msg) ) return()

             if(global.param$grp.done == F) return()
             if(!is.null(global.input$run.test))
                 if(global.input$run.test > 0) return()

             HTML(txt)
        })
    }

    ## ####################################################################
    ## analysis
    if(what == 'res'){

        txt <- paste('<p><font size=\"4\">This page allows you to interactively explore the results of you analyis. On the left you can choose between different filters, the results will be updated immediately. The filter that you specify applies to all tabs (\'Heatmap\', \'Volcanos\', ...), except the \'QC\' which shows the entire dataset. You can change the appearance of the heatmap by modifying the parameters below, you can select points shown in the Volcano plots and browse through the result table.</font></p><br>')

        ## render HTML
        output$html <- renderText({
        ##     if( !is.null(error$msg) ) return()

            if(global.param$grp.done == F) return()
            if(!is.null(global.input$run.test))
                if(global.input$run.test == 0) return()

            HTML(txt)
        })
    }


} ## end printHTML

