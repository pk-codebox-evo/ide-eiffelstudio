 <div class="col-xs-12">
	<ul class="pager">
		{if isset="$user"}
			<li><a href="{$host/}/user_reports/{$user/}?page=1&amp;size={$size/}&amp;category={$selected_category/}&amp;status={$selected_status/}&amp;orderBy={$orderBy/}&amp;dir={$dir/}" itemprop="first" rel="first">First</a></li>
			{if isset="$prev"}
				<li><a href="{$host/}/user_reports/{$user/}?page={$prev/}&amp;size={$size/}&amp;category={$selected_category/}&amp;status={$selected_status/}&amp;orderBy={$orderBy/}&amp;dir={$dir/}" itemprop="previous" rel="previous">Previous</a></li>
			{/if}
			{if isset="$next"}
				<li><a href="{$host/}/user_reports/{$user/}?page={$next/}&amp;size={$size/}&amp;category={$selected_category/}&amp;status={$selected_status/}&amp;orderBy={$orderBy/}&amp;dir={$dir/}"  itemprop="next" rel="next">Next</a></li>
			{/if}
			<li><a href="{$host/}/user_reports/{$user/}?page={$last/}&amp;size={$size/}&amp;category={$selected_category/}&amp;status={$selected_status/}&amp;orderBy={$orderBy/}&amp;dir={$dir/}"  itemprop="last" rel="last">Last</a></li>
		{/if}
		{unless isset="$user"}
			<li><a href="{$host/}/reports?page=1&amp;size={$size/}&amp;category={$selected_category/}&amp;status={$selected_status/}&amp;orderBy={$orderBy/}&amp;dir={$dir/}" itemprop="first" rel="first">First</a></li>
			{if isset="$prev"}
				<li><a href="{$host/}/reports?page={$prev/}&amp;size={$size/}&amp;category={$selected_category/}&amp;status={$selected_status/}&amp;orderBy={$orderBy/}&amp;dir={$dir/}" itemprop="previous" rel="previous">Previous</a></li>
			{/if}
			{if isset="$next"}
				<li><a href="{$host/}/reports?page={$next/}&amp;size={$size/}&amp;category={$selected_category/}&amp;status={$selected_status/}&amp;orderBy={$orderBy/}&amp;dir={$dir/}" itemprop="next" rel="next">Next</a></li>
			{/if}
			<li><a href="{$host/}/reports?page={$last/}&amp;size={$size/}&amp;category={$selected_category/}&amp;status={$selected_status/}&amp;orderBy={$orderBy/}&amp;dir={$dir/}" itemprop="last" rel="last">Last</a></li>
		{/unless}
	</ul>
</div>
