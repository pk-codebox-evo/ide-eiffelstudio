{include file="modules/search_by_report_id.tpl"/}

<div class="row">
	<div class="col-xs-12">
		<form class="form-inline well" action="{$host/}/user_reports/{$user/}" id="search" method="GET" itemprop="search">
			<input type="hidden" name="size" value="{$size/}"/>
			<div class="row">
				<div class="col-xs-3">
					<div class="row">
						<div class="col-xs-2">
							<label class="control-label-api" itemprop="category" data-original-title="The name of the product, component or concept where the problem lies. In order to get the best possible support, please select the category carefully.">Category</label>
						</div>
						<div class="col-xs-6">
							<select class="form-control" data-style="btn-primary" name="category" form="search" itemprop="search">
								<option value="0">ALL</option>
								{foreach from="$categories" item="item"}
									{if condition="$item.is_selected"} 
										<option value="{$item.id/}" selected>{$item.synopsis/}</option>
									{/if}
									{unless condition="$item.is_selected"}
										<option value="{$item.id/}">{$item.synopsis/}</option>
									{/unless}
								{/foreach}
							</select>
						</div>
					</div>
				</div>
				<div class="col-xs-3">
					<div class="row">
						<div class="col-xs-2">
							<label class="control-label-api" itemprop="status" data-original-title="The status of a problem can be one of the following: Open - Analyzed - Closed - Suspended - Won't Fix">Status</label>
						</div>
						<div class="col-xs-6">
							<select class="form-control" data-style="btn-primary" name="status" form="search">
								<option value="0">ALL</option>
								{foreach from="$status" item="item"}
									{if condition="$item.is_selected"}
										<option value="{$item.id/}" selected>{$item.synopsis/}</option>
									{/if}
									{unless condition="$item.is_selected"}
										<option value="{$item.id/}">{$item.synopsis/}</option>
									{/unless}
								{/foreach}
							</select>
						</div>
					</div>
				</div>
				<div class="col-xs-2">
					<button type="submit" class="btn btn-default">Search</button>
				</div>
			</div>
		</form>
	</div>
</div>

<h2 class="sub-header">Problem Reports: 
	<small>
		<ul class="pagination">
			<li class="info">Current page {$index/} of {$pages/} - </li>
			<li><label class="control-label-api" itemprop="size" data-original-title="The status of a problem can be one of the following: Open - Analyzed - Closed - Suspended - Won't Fix">Size</label> 
				<input type="number" name="quantity" min="1" max="9999" value="{$size/}" id="changesize"/>
			</li>
			<li><img src="{$host/}/static/images/ajax-loader.gif" alt="Loading..." style="display: none;" id="pageLoad" />
					<input type="hidden" name="current" value="{$host/}/user_reports/{$user/}?page={$index/}&amp;size={$size/}&amp;category={$selected_category/}&amp;status={$selected_status/}&amp;orderBy={$orderBy/}&amp;dir={$dir/}" id="currentPage"/>
			</li>
		</ul>
	</small>
</h2>
<div class="row">
	{include file="paging_user_reports.tpl"/}
</div> 
<div class="table table-responsive">
	<table class="table table-bordered" id="table">
		<thead>
			<tr>
				<th>
					{assign name="column" value="number"/}
					{assign name="ldir" value="ASC"/}
				
					{if condition="$view.order_by ~ $column"}
						{if condition="$view.direction ~ $ldir"}
							<a href="{$host/}/user_reports/{$user/}?page={$index/}&amp;size={$size/}&amp;orderBy={$column/}&amp;dir=DESC"># <img src="{$host/}/static/images/up.gif" class="img-rounded"/></a>
						{/if}
						{unless condition="$view.direction ~ $ldir"}
							<a href="{$host/}/user_reports/{$user/}?page={$index/}&amp;size={$size/}&amp;orderBy={$column/}&amp;dir=ASC"># <img src="{$host/}/static/images/down.gif" class="img-rounded"/></a>
						{/unless}
					{/if} 
					{unless condition="$view.order_by ~ $column"}
							<a href="{$host/}/user_reports/{$user/}?page={$index/}&amp;size={$size/}&amp;orderBy={$column/}&amp;dir=ASC"># </a>
					{/unless}
				</th>
				<th>
					{assign name="column" value="statusID"/}
					{assign name="ldir" value="ASC"/}
	
					{if condition="$view.order_by ~ $column"}
						{if condition="$view.direction ~ $ldir"}
							<a href="{$host/}/user_reports/{$user/}?page={$index/}&amp;size={$size/}&amp;orderBy={$column/}&amp;dir=DESC"><img src="{$host/}/static/images/grid_header.gif" class="img-rounded" alt="{$item.status.synopsis/}"/> 
								<img src="{$host/}/static/images/up.gif" class="img-rounded"/></a>
						{/if}
						{unless condition="$view.direction ~ $ldir"}
							<a href="{$host/}/user_reports/{$user/}?page={$index/}&amp;size={$size/}&amp;orderBy={$column/}&amp;dir=ASC"><img src="{$host/}/static/images/grid_header.gif" class="img-rounded" alt="{$item.status.synopsis/}"/> 
								<img src="{$host/}/static/images/down.gif" class="img-rounded"/></a>
						{/unless}
					{/if} 
					{unless condition="$view.order_by ~ $column"}
						<a href="{$host/}/user_reports/{$user/}?page={$index/}&amp;size={$size/}&amp;orderBy={$column/}&amp;dir=ASC"><img src="{$host/}/static/images/grid_header.gif" class="img-rounded" alt="{$item.status.synopsis/}"/> </a>
					{/unless}
				</th>
				<th>
					{assign name="column" value="synopsis"/}
					{assign name="ldir" value="ASC"/}
					
					{if condition="$view.order_by ~ $column"}
						{if condition="$view.direction ~ $ldir"}
							<a href="{$host/}/user_reports/{$user/}?page={$index/}&amp;size={$size/}&amp;orderBy={$column/}&amp;dir=DESC">Synopsis <img src="{$host/}/static/images/up.gif" class="img-rounded"/></a>
						{/if}
						{unless condition="$view.direction ~ $ldir"}
							<a href="{$host/}/user_reports/{$user/}?page={$index/}&amp;size={$size/}&amp;orderBy={$column/}&amp;dir=ASC">Synopsis <img src="{$host/}/static/images/down.gif" class="img-rounded"/></a>
						{/unless}
					{/if} 
					{unless condition="$view.order_by ~ $column"}
						<a href="{$host/}/user_reports/{$user/}?page={$index/}&amp;size={$size/}&amp;orderBy={$column/}&amp;dir=ASC">Synopsis </a>
					{/unless}
				</th>
				<th> 
					{assign name="column" value="submissionDate"/}
					{assign name="ldir" value="ASC"/}
					
					{if condition="$view.order_by ~ $column"}
						{if condition="$view.direction ~ $ldir"}
							<a href="{$host/}/user_reports/{$user/}?page={$index/}&amp;size={$size/}&amp;orderBy={$column/}&amp;dir=DESC">Date <img src="{$host/}/static/images/up.gif" class="img-rounded"/></a>
						{/if}
						{unless condition="$view.direction ~ $ldir"}
							<a href="{$host/}/user_reports/{$user/}?page={$index/}&amp;size={$size/}&amp;orderBy={$column/}&amp;dir=ASC">Date <img src="{$host/}/static/images/down.gif" class="img-rounded"/></a>
						{/unless}
					{/if} 
					{unless condition="$view.order_by ~ $column"}
						<a href="{$host/}/user_reports/{$user/}?page={$index/}&amp;size={$size/}&amp;orderBy={$column/}&amp;dir=ASC">Date </a>
					{/unless}
				</th>
				<th>
					{assign name="column" value="categorySynopsis"/}
					{assign name="ldir" value="ASC"/}
				
					{if condition="$view.order_by ~ $column"}
						{if condition="$view.direction ~ $ldir"}
							<a href="{$host/}/user_reports/{$user/}?page={$index/}&amp;size={$size/}&amp;orderBy={$column/}&amp;dir=DESC">Category <img src="{$host/}/static/images/up.gif" class="img-rounded"/></a>
						{/if}
						{unless condition="$view.direction ~ $ldir"}
							<a href="{$host/}/user_reports/{$user/}?page={$index/}&amp;size={$size/}&amp;orderBy={$column/}&amp;dir=ASC">Category <img src="{$host/}/static/images/down.gif" class="img-rounded"/></a>
						{/unless}
					{/if} 
					{unless condition="$view.order_by ~ $column"}
						<a href="{$host/}/user_reports/{$user/}?page={$index/}&amp;size={$size/}&amp;orderBy={$column/}&amp;dir=ASC">Category </a>
					{/unless}
				</th>
			</tr>
		</thead>
		<tbody>
			{foreach from="$reports" item="item"}
				<tr>
					<td itemprop="report_number"><a href="{$host/}/report_detail/{$item.number/}" itemprop="report_interaction" rel="report_interaction">{$item.number/}</a></td>
					<td class="text-center" itemprop="status">
							<a href="{$host/}/user_reports/{$user/}?category=0&amp;status={$item.status.id/}" rel="filter"><img src="{$host/}/static/images/status_{$item.status.id/}.gif" class="img-rounded" data-original-title="{$item.status.synopsis/}"/></a>
					</td>

					<td itemprop="synopsis">{$item.synopsis/}</td>
					<td itemprop="submission_date">{$item.submission_date_output/}</td>
					<td itemprop="category"> {$item.category.synopsis/}</td> 
				</tr>
			{/foreach}
						
		</tbody>
	</table>
	{include file="paging_user_reports.tpl"/}
</div>
