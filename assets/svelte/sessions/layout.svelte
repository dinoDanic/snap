<script lang="ts">
  export let sessions: { id: number }[] = [];
  console.log(sessions);
</script>

<div class="grid h-[100vh] grid-cols-1 grid-rows-[1fr_20px] overflow-auto p-1">
  <div>
    <slot />
  </div>
  <div>
    <!-- {#each sessions as session, index} -->
    <!--   <p>{session.id}</p> -->
    <!-- {/each} -->
  </div>
</div>
