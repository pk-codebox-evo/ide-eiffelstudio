<h1 class="sub-header">PR# {$report.number/} {$report.synopsis/} </h1>
 
  <div class="row">
  <div class="col-lg-16">
       <div class="panel panel-default">
              <div class="panel-heading">Problem Report Summary</div>
              <div class="panel-body">
  <div class="form-horizontal well" >
      <!--form -->
      <div class="row">
       <div class="span8">
          <div class="row">   
              <div class="col-lg-4 lightblue">
                  <span class="label label-primary-api" itemprop="submitter">Submitter</span> : <td class="label">{$report.contact.name/}</td> </br>
              </div>
              <div class="col-lg-4 lightblue">
                  <span class="label label-primary-api" itemprop="category">Category</span> : <td>{$report.category.synopsis/}</td> </br>
              </div>
              <div class="col-lg-4 lightblue">
                  <span class="label label-primary-api" itemprop="priority">Priority</span> : <td>{$report.priority.synopsis/}</td> </br>
              </div>
         </div>
         <div class="row">  
                <div class="col-lg-4 lightblue">
                  <span class="label label-primary-api" itemprop="date">Date</span> : <td>{$report.submission_date_output/}</td> </br>
              </div>
              <div class="col-lg-4 lightblue">
                  <span class="label label-primary-api" itemprop="class">Class</span> : <td>{$report.report_class.synopsis/}</td> </br>
              </div>
              <div class="col-lg-4 lightblue">
                 <span class="label label-primary-api" itemprop="severity">Severity</span> : <td>{$report.severity.synopsis/}</td> </br>
             </div>
           </div>
          <div class="row">   
              <div class="col-lg-4 lightblue">
                  <span class="label label-primary-api" itemprop="report_number">Number</span> : <td>{$report.number/}</td> </br>
              </div>
              <div class="col-lg-4 lightblue">
                  <span class="label label-primary-api" itemprop="release">Release</span> : <td>{$report.release/}</td> </br>
              </div>
              <div class="col-lg-4 lightblue">
                  <span class="label label-primary-api" itemprop="confidential">Confidential</span> : <td>{$report.confidential/}</td> </br>
             </div>
           </div>  
          <div class="row">      
             <div class="col-lg-4 lightblue">
                  <span class="label label-primary-api" itemprop="status">Status</span> : <td>{$report.status.synopsis/}</td> </br>
               </div>
              <div class="col-lg-4 lightblue">
                  <span class="label label-primary-api" itemprop="responsible">Responsible</span> : <td></td> </br>
              </div>
              <div class="col-lg-4 lightblue">
                  <span class="label label-primary-api" itemprop="environment">Environment</span> : <td>{$report.environment/}</td> </br>
              </div>
           </div>
            <div class="row">
                <div class="col-lg-4 lightblue">
                  <span class="label label-primary-api" itemprop="synopsis">Synopsis</span> : <td>{$report.synopsis/}</td> </br>
                </div>
            </div>    

          <div class="row">
          <div class="col-lg-12">
            <div class="panel panel-default">
              <div class="panel-heading" itemprop="description">Description</div>
              <div class="panel-body"><pre>{$report.description/}</pre></div>
            </div>
          </div>
         </div>
          <div class="row">
          <div class="col-lg-12">
            <div class="panel panel-default">
              <div class="panel-heading" itemprop="to_reproduce">To Reproduce</div>
              <div class="panel-body"><pre>{$report.to_reproduce/}</pre></div>
            </div>
          </div> 
         </div>  
        </div> <!-- span -->
      </div>
      <!--form -->
    </div>     

    </div>
    </div>
    </div>
    </div>        

  <div class="row">
  <div class="col-lg-16">
       <div class="panel panel-default">
              <div class="panel-heading">Problem Report Summary</div>
              <div class="panel-body">
  <div class="form-horizontal well">
      <!--form -->
      <div class="row">
      <div class="span8">
                 
      {foreach from="$report.interactions" item="item"}
                    <div class="row">
                      <div class="col-lg-12">
                      <div class="panel panel-default">
                        <div class="panel-heading"> <span class="label label-primary" itemprop="submitter">From:</span> {$item.contact.name/}   <span class="label label-primary" itemprop="date">Date:</span>{$item.date/}    <span class="label label-primary" itemprop="status">Status:</span> {$item.status/}</div>
                        <div class="panel-body">{$item.content/} <br>
                                    {foreach from="$item.attachments" item="elem"}
                                         <div class="row">
                                         <div class="col-lg-8">
                                          <div class="panel panel-default">
                                            <div class="panel-heading">
                                                <span class="label label-primary" itemprop="attachment">Attachment:</span> <a href="{$host/}/report_interaction/{$elem.id/}/{$elem.name/}"  download="{$elem.name/}">{$elem.name/}</a>   <span class="label label-primary">Size:</span> {$elem.bytes_count/} </div>
                                          </div> 
                                         </div>
                                        </div>  
                                    {/foreach}

                        </div>      
            
                      </div>
                      </div> 
                    </div>  
                    
        {/foreach}
      <!--form -->
    </div>
    </div>     
    </div>
    </div>
    </div>
    </div>
    </div>        

        {if isset="$user"}
            <div class="btn-group">
                <a href="{$host/}/report_detail/{$report.number/}/interaction_form" class="btn btn-primary" itemprop="create-interaction-form" rel="create-interaction-form">
                    Add Interaction
                </a>
            </div> 
         {/if}
</div>